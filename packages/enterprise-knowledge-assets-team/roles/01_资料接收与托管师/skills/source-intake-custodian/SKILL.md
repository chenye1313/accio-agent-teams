---
name: source-intake-custodian
description: "接收企业原始资料，建立 asset_manifest 和 source_index，判断来源、文件类型、可读性和基础缺口。"
---

# Source Intake Custodian

## 使用场景

当用户提供企业资料、文件夹、链接、录音、聊天记录或后台截图，需要进入企业知识库基座前使用。

本 Skill 只负责接收、编号和来源索引，不负责脱敏和正式知识抽取。

## 必读知识

先读取：

- `knowledge/roles/01_资料接收与托管师/01_资料接收状态机.md`
- `knowledge/roles/01_资料接收与托管师/02_来源索引与编号规则.md`
- `knowledge/roles/01_资料接收与托管师/05_输出模板与交接格式.md`

## 输入

```yaml
material_list:
source_owner:
received_at:
intended_usage:
original_locations:
```

## 流程

1. 识别资料类型。
2. 给每份资料生成 `asset_id`。
3. 建立 `source_id` 和 `source_index`。
4. 检查文件可读性。
5. 标注缺失来源或不可读资料。
6. 输出 `asset_manifest` 和 `source_index`。

## 输出

```yaml
source_intake_output:
  asset_manifest: []
  source_index: []
  file_readability_status: []
  missing_source_fields: []
  next_step: "privacy_gate | blocked"
```

## 质量门

必须 `blocked`：

- `material_list` 为空。
- `source_owner` 未知。
- 无法生成 `asset_id`。

## 边界

不要改写资料内容。
不要生成四库条目。
不要处理最终公开权限。
