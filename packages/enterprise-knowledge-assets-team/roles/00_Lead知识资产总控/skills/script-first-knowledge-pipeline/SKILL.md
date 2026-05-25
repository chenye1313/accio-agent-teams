---
name: script-first-knowledge-pipeline
description: "在知识库抽取、读书知识库、企业资料整理或全量批处理前，先用脚本完成可重复的解析、拆分、校验和微任务编排，再把语义判断交给 AI。"
---

# Script First Knowledge Pipeline

## 使用场景

当任务涉及以下任一情况时使用：

- PDF、PPT、录音转写、聊天记录、书籍、企业资料进入知识库。
- 需要批量拆出原理、框架、案例、术语、问答或反模式。
- Agent 在大任务中出现笼统报错、空目录、漏条目、引用悬挂。
- 用户要求提高速度、标准化或减少 AI 算法式随机执行。

## 第一原则

不要让 AI 做流水线。

AI 负责语义抽象和判断；脚本负责可重复、可验证、可复现的工程动作。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/07_脚本优先执行层.md`
- `knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md`
- `knowledge/roles/03_知识质量与分发官/03_四库条目验收与AI-Slop扫描.md`

## 脚本路径

```bash
agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py
```

## 标准执行顺序

1. 先跑 inventory，确认 raw/schema/sample/full 的真实状态。
2. 再跑 check，确认 ID、引用、source、quote 和 case v0.2 字段。
3. 如果任务超过微任务粒度门，用 microtasks 生成微任务表。
4. 只把单个微任务派给 AI：`1 个 raw section + 1 个库 + ≤5 条`。
5. 每个微任务写完后立刻跑 check。
6. check 通过后再派下一个微任务。
7. 批次完成后由总控做语义验收。

## 常用命令

```bash
python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py inventory --kb-root output/读书知识库/内容红利
```

```bash
python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py check --kb-root output/读书知识库/内容红利
```

```bash
python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py microtasks \
  --kb-root output/读书知识库/内容红利 \
  --batch batch_1 \
  --sections 00_preface.md,01-01_定位与人设.md \
  --libraries principles,cases,glossary,anti_patterns \
  --max-items 5 \
  --write
```

## AI 任务上限

```yaml
one_ai_task:
  raw_sections: 1
  libraries: 1
  max_new_items: 5
  output_file: "明确到单一 yaml/md 文件"
  required_after_write:
    - "run deterministic check"
    - "report file path + IDs + error_count"
```

## 失败处理

如果 Agent 报笼统错误：

1. 不要重派同样的大任务。
2. 先运行 `inventory` 看是否已有半成品。
3. 再运行 `check` 找具体错误。
4. 若目录为空，拆成更小微任务。
5. 若 `check` 有结构错误，先修结构，不继续抽取。

连续两次笼统错误后，任务必须转为脚本诊断，不允许继续盲试。

## 输出

总控输出必须包含：

```yaml
script_first_pipeline_result:
  inventory_checked: true
  check_error_count:
  check_warning_count:
  microtask_plan:
  ai_tasks_allowed:
  blocked_reason:
  next_action:
```
