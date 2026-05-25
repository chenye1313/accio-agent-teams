---
name: jtbd-buyer-task-analyzer
description: "根据 BusinessModel 输出和 client_profile.yaml，把外贸 B2B 目标买家拆成采购角色、核心 Job、替代方案、Desired Outcomes、采购焦虑和雇用/解雇标准。"
---

# JTBD Buyer Task Analyzer

## 使用场景

当已经有 `business_model_analysis`，并需要把“优先买家”升级成“买家为什么采购、如何衡量成功、为什么换供应商”时使用。

本 Skill 只负责 Buyer JTBD，不负责企业能力证明、差异化定位、页面表达或最终报告。

## 必读知识

先读取：

- `knowledge/roles/03_BuyerJTBD买家任务分析师/01_JTBD核心定义与禁忌.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/02_B2B多角色采购任务拆解.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/03_成功指标DesiredOutcomes构造规则.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/06_输出模板与交接格式.md`
- `knowledge/shared/07_经营数据证据门.md`

按需读取：

- `knowledge/roles/03_BuyerJTBD买家任务分析师/04_访谈与追问脚本.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/05_案例JTBD校准.md`

## 输入

必须有：

```yaml
business_model_analysis:
  primary_business_model:
  handoff_to_buyer_jtbd:
    priority_buyer:
    buyer_stage:
    core_assumption_to_validate:

client_profile_yaml:
  main_products:
  target_buyer_types:
  buyer_pain_points_known:
  buyer_success_metrics_known:

inquiry_buyer_segments:
```

## 流程

1. 确认优先买家和买家阶段。
2. 调用或读取 `inquiry-sales-segmenter`，用真实询盘校准优先买家。
3. 拆解 B2B 采购委员会。
4. 构造不含产品名的核心 Job。
5. 写出挣扎时刻和当前替代方案。
6. 构造至少 3 个 Desired Outcomes。
7. 写出采购焦虑、雇用标准和解雇标准。
8. 生成交给 SupplyMapping 的能力关键词。

## 输出

必须输出：

```yaml
buyer_jtbd_analysis:
  role_id: "03_BuyerJTBD买家任务分析师"
  status: "pass" # pass | need_more_info | blocked
  priority_buyer:
    name:
    stage:
    source_from_business_model:
    source_from_inquiry_data:
    confidence:
  buyer_roles:
    job_executor:
      who:
      job:
      success_metrics:
    purchaser:
      who:
      job:
      success_metrics:
    decision_maker:
      who:
      job:
      success_metrics:
    influencer:
      who:
      job:
      success_metrics:
    beneficiary:
      who:
      job:
      success_metrics:
  core_job:
    statement:
    functional_dimension:
    emotional_dimension:
    social_dimension:
    forbidden_product_words_checked: true
  struggling_moment:
  current_workaround:
  desired_outcomes:
    - statement:
      outcome_type: "time | risk | cost | revenue | trust"
      buyer_role:
      linked_capability_needed:
  purchase_anxiety:
  hire_criteria:
  fire_criteria:
  unsupported_or_uncertain:
  mismatch_warning:
  handoff_to_supply_mapping:
    core_job:
    desired_outcomes_to_match:
    capability_keywords_to_check:
```

## 质量门

必须阻断：

- 无 `priority_buyer`。
- `core_job` 含产品名。
- 无 `current_workaround`。
- `desired_outcomes` 少于 3 个。
- 未区分采购执行者和决策者。

必须降级为 `need_more_info`：

- 缺采购情境。
- 缺替代方案。
- 缺雇用/解雇标准。
- 只有泛泛痛点，无法构造成功指标。
- 缺真实询盘时，买家判断必须标注为推断。

## 边界

不要输出：

- 企业能力是否足够。
- 差异化定位语。
- Slogan。
- 阿里国际站 7 屏 brief。
- Lead 最终质量门。
