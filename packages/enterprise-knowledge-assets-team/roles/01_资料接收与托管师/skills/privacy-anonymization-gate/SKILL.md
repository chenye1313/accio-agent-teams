---
name: privacy-anonymization-gate
description: "检查企业资料中的敏感信息、脱敏状态、公开权限和不可外发清单，决定是否可进入知识构建。"
---

# Privacy Anonymization Gate

## 使用场景

当资料已经建立来源索引，需要判断是否可交给知识资产构建师前使用。

本 Skill 只做隐私和权限门，不负责正式知识抽取。

## 必读知识

先读取：

- `knowledge/roles/01_资料接收与托管师/03_脱敏与权限标注规则.md`
- `knowledge/roles/01_资料接收与托管师/05_输出模板与交接格式.md`
- `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md`

## 输入

```yaml
asset_manifest:
source_index:
intended_usage:
raw_sensitive_signals:
```

## 流程

1. 检查客户名、联系方式、成交价、合同、付款信息。
2. 标注 `privacy_level`。
3. 标注 `permission_status`。
4. 生成 `anonymization_required`。
5. 生成 `restricted_items`。
6. 判断是否可以进入知识构建。

## 输出

```yaml
privacy_gate_output:
  status: "pass | pass_with_gap | fail"
  sensitive_items: []
  anonymization_required: []
  permission_tags: []
  restricted_items: []
  required_fix: []
```

## 质量门

必须 `fail`：

- 客户联系方式未处理。
- 具体成交价要进入对外用途。
- 权限未知资料要进入公开内容。
- 合同或付款信息进入普通资料包。

## 边界

不要替客户确认公开授权。
不要删除来源索引。
不要把 `unknown` 改成 `public`。
