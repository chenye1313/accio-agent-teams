---
name: evidence-source-quality-auditor
description: "检查企业知识资产四库候选条目的来源、证据等级、权限、脱敏和来源一致性，决定能否进入正式质量评审。"
---

# Evidence Source Quality Auditor

## 使用场景

当 `02_知识资产构建师` 交付四库候选条目后，先用本 Skill 审查来源和权限。

本 Skill 只负责证据与权限，不负责业务内容重写。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md`
- `knowledge/roles/03_知识质量与分发官/01_质量分发状态机.md`
- `knowledge/roles/03_知识质量与分发官/02_证据等级与来源一致性规则.md`

## 输入

```yaml
candidate_items:
source_index:
permission_tags:
inference_log:
```

## 流程

1. 检查每条候选是否有 `source_id`。
2. 检查来源是否能支撑候选结论。
3. 给出 A/B/C/D 证据等级。
4. 检查客户名、价格、联系方式等隐私。
5. 检查公开权限和目标使用场景是否冲突。
6. 输出可进入质量评审、待验证、内部使用、拒绝四类结果。

## 输出

```yaml
evidence_source_quality_output:
  approved_for_quality_review: []
  needs_validation_items: []
  internal_only_items: []
  rejected_items: []
  source_conflicts: []
  privacy_required_fixes: []
```

## 质量门

必须拒绝：

- 没有来源。
- 来源无法支撑结论。
- 隐私未脱敏。
- 权限未知却要对外公开。
- 口述经验被写成确定事实。

## 边界

不要补写上游缺失事实。
不要替客户确认公开权限。
不要为了通过质量门而弱化证据缺口。

