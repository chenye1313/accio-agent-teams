---
name: knowledge-asset-evidence-gate
description: "检查企业知识资产条目的来源、证据等级、隐私脱敏、公开权限和可分发状态，决定 pass、pass_with_gap 或 fail。"
---

# Knowledge Asset Evidence Gate

## 使用场景

当四库候选条目准备进入正式知识库、准备分发给六组、或准备用于对外内容前使用。

本 Skill 只判断证据、隐私和质量，不负责补写事实。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md`
- `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md`
- `knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md`

## 输入

```yaml
library_candidates:
  enterprise_info: []
  product_info: []
  customer_qa: []
  customer_case: []
source_index:
privacy_tags:
public_permission:
target_usage:
```

## 流程

1. 检查每条知识是否有 `source_id`。
2. 检查客户名、联系方式、成交价、合同和付款信息是否脱敏。
3. 按 A/B/C/D 给证据等级。
4. 判断公开权限：`public | anonymized | internal_only | unknown`。
5. 检查四库字段最低门槛。
6. 标记 `approved | needs_validation | internal_only | rejected`。
7. 对失败项输出返工角色和补救动作。

## 输出

```yaml
evidence_privacy_gate:
  status: "pass | pass_with_gap | fail"
  approved_items:
    - item_id: ""
      evidence_level: ""
      allowed_usage: []
  needs_validation_items:
    - item_id: ""
      reason: ""
      return_to_role: ""
  internal_only_items:
    - item_id: ""
      reason: ""
  rejected_items:
    - item_id: ""
      reason: ""
      required_fix: ""
  required_fix:
    - return_to_role: ""
      issue: ""
      required_action: ""
```

## 质量门

必须 `fail`：

- 来源缺失。
- 隐私未脱敏。
- 公开权限未知却要对外使用。
- 无证据优势要进入正式库。
- 案例缺问题、方案或结果。

必须 `needs_validation`：

- 只有老板或销售口述。
- 只有公司宣传语。
- 方法经验未被案例或数据验证。

## 边界

不要补写缺失来源。
不要替客户确认公开权限。
不要把 C/D 级证据包装成 A/B 级。
