#!/usr/bin/env bash
set -euo pipefail

REPO_ARCHIVE_URL="${REPO_ARCHIVE_URL:-https://github.com/chenye1313/accio-agent-teams/archive/refs/heads/main.zip}"
TEAM=""
ACCIO_AGENT_READY_ROOT="${ACCIO_AGENT_READY_ROOT:-}"
ACCIO_TEAM_ROOT="${ACCIO_TEAM_ROOT:-}"
SOURCE_ROOT=""

usage() {
  printf '%s\n' "Usage: mac.sh --team <team-key> [--accio-agent-ready-root <path>] [--team-root <path>] [--source-root <path>]"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --team)
      TEAM="$2"
      shift 2
      ;;
    --accio-agent-ready-root)
      ACCIO_AGENT_READY_ROOT="$2"
      shift 2
      ;;
    --team-root)
      ACCIO_TEAM_ROOT="$2"
      shift 2
      ;;
    --source-root)
      SOURCE_ROOT="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown argument: %s\n' "$1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ -z "$TEAM" ]]; then
  usage >&2
  exit 1
fi

case "$TEAM" in
  foreign-trade-business-positioning-team)
    TEAM_NAME="外贸经营定位专家Team"
    ;;
  enterprise-knowledge-assets-team)
    TEAM_NAME="企业知识资产中心Team"
    ;;
  *)
    printf 'Unknown team key: %s\n' "$TEAM" >&2
    exit 1
    ;;
esac

if [[ -z "$SOURCE_ROOT" ]]; then
  TMP_DIR="$(mktemp -d)"
  ARCHIVE="$TMP_DIR/repo.zip"
  curl -fsSL "$REPO_ARCHIVE_URL" -o "$ARCHIVE"
  unzip -q "$ARCHIVE" -d "$TMP_DIR"
  SOURCE_ROOT="$(find "$TMP_DIR" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
fi

TEAM_SRC="$SOURCE_ROOT/packages/$TEAM"
if [[ ! -d "$TEAM_SRC" ]]; then
  printf 'Team source not found: %s\n' "$TEAM_SRC" >&2
  exit 1
fi

if [[ -n "$ACCIO_TEAM_ROOT" ]]; then
  DEST_TEAM="$ACCIO_TEAM_ROOT"
elif [[ -n "$ACCIO_AGENT_READY_ROOT" ]]; then
  DEST_TEAM="$ACCIO_AGENT_READY_ROOT/Teams/$TEAM_NAME"
else
  DEST_TEAM="$HOME/.accio/agent-ready/Teams/$TEAM_NAME"
fi

mkdir -p "$(dirname "$DEST_TEAM")"

if [[ -d "$DEST_TEAM" ]]; then
  BACKUP="$DEST_TEAM.backup-$(date +%Y%m%d-%H%M%S)"
  mv "$DEST_TEAM" "$BACKUP"
  printf 'Existing team backed up to: %s\n' "$BACKUP"
fi

cp -R "$TEAM_SRC" "$DEST_TEAM"

printf 'Installed team: %s\n' "$DEST_TEAM"
printf 'Role count: %s\n' "$(find "$DEST_TEAM/roles" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')"
printf 'Skill count: %s\n' "$(find "$DEST_TEAM/roles" -path '*/skills/*/SKILL.md' -type f | wc -l | tr -d ' ')"
printf 'Output guide: %s\n' "$DEST_TEAM/output/README.md"
