#!/usr/bin/env python3
"""Deterministic helpers for knowledge-base extraction projects.

The scripts in this file do not replace semantic extraction. They handle the
repeatable parts that should not be delegated to an LLM: inventory, ID/ref
checks, quote limits, source-field checks, and microtask scaffolding.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass
from pathlib import Path


ID_RE = re.compile(r"\b(?:AP|P|F|C|T)-\d{3}\b")
ENTRY_ID_RE = re.compile(r"(?m)^\s*-\s+id:\s*['\"]?((?:AP|P|F|C|T)-\d{3})['\"]?\s*$")
QUOTE_RE = re.compile(r"(?m)^\s*supporting_quote:\s*(.+?)\s*$")
SOURCE_FIELDS = ("book", "author", "chapter", "section", "page")


@dataclass
class Entry:
    item_id: str
    path: Path
    block: str


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Knowledge pipeline deterministic tools")
    sub = parser.add_subparsers(dest="command", required=True)

    for name in ("inventory", "check"):
        p = sub.add_parser(name)
        p.add_argument("--kb-root", required=True, help="Knowledge-base root, e.g. output/读书知识库/内容红利")
        p.add_argument("--json", action="store_true", help="Emit JSON")

    p = sub.add_parser("microtasks")
    p.add_argument("--kb-root", required=True)
    p.add_argument("--batch", required=True, help="Batch name, e.g. batch_1")
    p.add_argument("--sections", default="", help="Comma-separated raw markdown filenames. Empty means all raw files.")
    p.add_argument("--libraries", default="principles,frameworks,cases,glossary,anti_patterns")
    p.add_argument("--max-items", type=int, default=5)
    p.add_argument("--write", action="store_true", help="Write workplan/microtasks_<batch>.md")
    p.add_argument("--json", action="store_true")
    return parser.parse_args()


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def yaml_entry_files(kb_root: Path) -> list[Path]:
    files: list[Path] = []
    for dirname in ("samples", "full"):
        root = kb_root / dirname
        if root.exists():
            files.extend(sorted(root.rglob("*.yaml")))
            files.extend(sorted(root.rglob("*.yml")))
    return files


def collect_entries(kb_root: Path) -> list[Entry]:
    entries: list[Entry] = []
    for path in yaml_entry_files(kb_root):
        text = read_text(path)
        matches = list(ENTRY_ID_RE.finditer(text))
        for index, match in enumerate(matches):
            start = match.start()
            end = matches[index + 1].start() if index + 1 < len(matches) else len(text)
            entries.append(Entry(match.group(1), path, text[start:end]))
    return entries


def parse_front_matter(path: Path) -> dict[str, str]:
    text = read_text(path)
    if not text.startswith("---"):
        return {}
    end = text.find("\n---", 3)
    if end < 0:
        return {}
    data: dict[str, str] = {}
    for line in text[3:end].splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        data[key.strip()] = value.strip().strip('"')
    return data


def inventory(kb_root: Path) -> dict:
    raw_dir = kb_root / "00_raw"
    schema_dir = kb_root / "schema"
    entries = collect_entries(kb_root)
    by_prefix = Counter(item.item_id.split("-", 1)[0] for item in entries)
    raw_files = sorted(raw_dir.glob("*.md")) if raw_dir.exists() else []
    word_count = 0
    page_ranges = []
    for raw in raw_files:
        fm = parse_front_matter(raw)
        try:
            word_count += int(fm.get("word_count", "0"))
        except ValueError:
            pass
        if fm.get("page_start") and fm.get("page_end"):
            page_ranges.append({"file": raw.name, "page_start": fm["page_start"], "page_end": fm["page_end"]})
    return {
        "kb_root": str(kb_root),
        "raw_file_count": len(raw_files),
        "raw_word_count": word_count,
        "schema_file_count": len(list(schema_dir.glob("*.yaml"))) if schema_dir.exists() else 0,
        "entry_file_count": len(yaml_entry_files(kb_root)),
        "entry_count": len(entries),
        "entry_count_by_prefix": dict(sorted(by_prefix.items())),
        "page_ranges_sample": page_ranges[:8],
    }


def line_for(path: Path, needle: str) -> int:
    for index, line in enumerate(read_text(path).splitlines(), start=1):
        if needle in line:
            return index
    return 1


def check(kb_root: Path) -> dict:
    entries = collect_entries(kb_root)
    definitions: dict[str, Path] = {}
    duplicates: dict[str, list[str]] = defaultdict(list)
    errors: list[str] = []
    warnings: list[str] = []

    for entry in entries:
        if entry.item_id in definitions:
            duplicates[entry.item_id].append(str(entry.path))
        else:
            definitions[entry.item_id] = entry.path

    for item_id, paths in sorted(duplicates.items()):
        first = definitions[item_id]
        errors.append(f"duplicate_id {item_id}: {first} + {paths}")

    refs = defaultdict(set)
    for entry in entries:
        for ref in ID_RE.findall(entry.block):
            if ref != entry.item_id:
                refs[entry.item_id].add(ref)
        if "source:" not in entry.block:
            errors.append(f"missing_source {entry.item_id}: {entry.path}")
        else:
            for field in SOURCE_FIELDS:
                if not re.search(rf"(?m)^\s+{field}:\s*", entry.block):
                    errors.append(f"missing_source_field {entry.item_id}.{field}: {entry.path}")
        if entry.item_id.startswith("C-") and "/full/" in str(entry.path):
            for field in ("negative_for", "era_context", "lifecycle"):
                if not re.search(rf"(?m)^\s+{field}:\s*", entry.block):
                    warnings.append(f"case_missing_v0_2_field {entry.item_id}.{field}: {entry.path}")
        for quote_match in QUOTE_RE.finditer(entry.block):
            quote = quote_match.group(1).strip().strip('"').strip("'")
            clean = quote.strip()
            if not (clean.startswith("「") and clean.endswith("」")):
                warnings.append(f"supporting_quote_not_wrapped {entry.item_id}: {entry.path}")
            quote_body = clean.strip("「」")
            if len(quote_body) > 30:
                warnings.append(f"supporting_quote_over_30_chars {entry.item_id}: {len(quote_body)} chars: {entry.path}")

    missing_refs = []
    for owner, owner_refs in refs.items():
        for ref in sorted(owner_refs):
            if ref not in definitions:
                missing_refs.append({"owner": owner, "missing_ref": ref, "path": str(definitions.get(owner, ""))})
                errors.append(f"missing_ref {owner}->{ref}: {definitions.get(owner, '')}")

    return {
        "kb_root": str(kb_root),
        "entries_checked": len(entries),
        "defined_ids": sorted(definitions),
        "reference_edges": sum(len(v) for v in refs.values()),
        "missing_refs": missing_refs,
        "errors": errors,
        "warnings": warnings,
        "error_count": len(errors),
        "warning_count": len(warnings),
    }


def build_microtasks(args: argparse.Namespace) -> dict:
    kb_root = Path(args.kb_root).expanduser().resolve()
    raw_dir = kb_root / "00_raw"
    if not raw_dir.exists():
        raise SystemExit(f"Missing raw dir: {raw_dir}")

    if args.sections:
        wanted = [item.strip() for item in args.sections.split(",") if item.strip()]
        raw_files = [raw_dir / name for name in wanted]
    else:
        raw_files = sorted(raw_dir.glob("*.md"))

    missing = [str(path) for path in raw_files if not path.exists()]
    if missing:
        raise SystemExit("Missing raw files: " + ", ".join(missing))

    libraries = [item.strip() for item in args.libraries.split(",") if item.strip()]
    tasks = []
    number = 1
    for raw in raw_files:
        fm = parse_front_matter(raw)
        for library in libraries:
            tasks.append(
                {
                    "task_id": f"{args.batch}.{number:02d}",
                    "raw_file": str(raw.relative_to(kb_root)),
                    "chapter": fm.get("chapter", ""),
                    "section": fm.get("section", raw.stem),
                    "page_range": f"p.{fm.get('page_start', '?')}-{fm.get('page_end', '?')}",
                    "library": library,
                    "max_items": args.max_items,
                    "rule": "one raw section + one library + max_items cap; run check after writing",
                }
            )
            number += 1

    result = {"kb_root": str(kb_root), "batch": args.batch, "task_count": len(tasks), "tasks": tasks}

    if args.write:
        out = kb_root / "workplan" / f"microtasks_{args.batch}.md"
        out.parent.mkdir(parents=True, exist_ok=True)
        lines = [
            f"# Microtasks · {args.batch}",
            "",
            "每个微任务只允许处理一个 raw section 和一个库，单次新增条目不得超过 max_items。",
            "完成后必须运行：",
            "",
            "```bash",
            f"python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py check --kb-root {kb_root}",
            "```",
            "",
            "| task_id | raw_file | section | pages | library | max_items |",
            "|---|---|---|---|---|---|",
        ]
        for task in tasks:
            lines.append(
                f"| {task['task_id']} | `{task['raw_file']}` | {task['section']} | {task['page_range']} | {task['library']} | {task['max_items']} |"
            )
        out.write_text("\n".join(lines) + "\n", encoding="utf-8")
        result["written"] = str(out)
    return result


def print_text(data: dict) -> None:
    for key, value in data.items():
        if isinstance(value, (dict, list)):
            print(f"{key}={json.dumps(value, ensure_ascii=False)}")
        else:
            print(f"{key}={value}")


def main() -> None:
    args = parse_args()
    if args.command == "microtasks":
        data = build_microtasks(args)
    else:
        kb_root = Path(args.kb_root).expanduser().resolve()
        if not kb_root.exists():
            raise SystemExit(f"Missing kb root: {kb_root}")
        data = inventory(kb_root) if args.command == "inventory" else check(kb_root)

    if getattr(args, "json", False):
        print(json.dumps(data, ensure_ascii=False, indent=2))
    else:
        print_text(data)

    if args.command == "check" and data.get("error_count", 0):
        sys.exit(1)


if __name__ == "__main__":
    main()
