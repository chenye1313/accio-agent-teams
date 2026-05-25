---
name: business-model-classifier
description: "根据外贸企业 client_profile.yaml 判断主生意模式、辅模式、不适合模式、证据强度和交给 BuyerJTBD 的分析方向。"
---

# Business Model Classifier

## 使用场景

当已经有 Intake 产出的 `client_profile.yaml`，需要判断外贸企业到底做哪盘生意时使用。

本 Skill 只负责经营模式判断，不负责最终定位、买家 Job 深挖、差异化话术或页面表达。

## 必读知识

先读取：

- `knowledge/roles/02_BusinessModel生意模式分析师/01_经营模式分类与判别规则.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/02_证据字段与评分规则.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/03_B2B模式选型决策树.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/06_输出模板与交接格式.md`
- `knowledge/shared/07_经营数据证据门.md`

按需读取：

- `knowledge/roles/02_BusinessModel生意模式分析师/04_飞轮与经营罗盘校验.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/05_案例模式校准.md`

## 输入

必须有：

```yaml
client_profile_yaml:
  main_products:
  current_business_model:
  target_buyer_types:
  priority_buyer:
  main_order_type:
  customization_services:
  rd_capabilities:
  delivery_cycle:
  capacity:
sku_performance_map:
store_performance_snapshot:
inquiry_buyer_segments:
```

## 流程

1. 生成候选经营模式。
2. 调用或读取 `sku-performance-mapper`，确认真实主推产品和产品经营表现。
3. 对每个候选模式做证据评分。
4. 选择唯一 `primary_business_model`。
5. 标记 `secondary_business_models`。
6. 标记 `unsuitable_models`。
7. 检查飞轮和经营罗盘指标。
8. 输出 `handoff_to_buyer_jtbd`。

## 输出

必须输出：

```yaml
business_model_analysis:
  role_id: "02_BusinessModel生意模式分析师"
  status: "pass" # pass | need_more_info | blocked
  primary_business_model:
    name:
    score:
    one_sentence_reason:
    evidence:
      buyer_evidence:
      order_evidence:
      capability_evidence:
      profit_or_repeat_logic:
      flywheel_logic:
  secondary_business_models:
  unsuitable_models:
  model_risks:
  sku_business_implication:
  decision_sufficiency_note:
  flywheel_check:
  missing_fields:
  handoff_to_buyer_jtbd:
```

## 质量门

必须阻断：

- 无 `priority_buyer`。
- 无 `main_order_type`。
- 无能力证据。
- 主模式得分低于辅模式。
- 输出多个并列主模式。

必须降级为 `need_more_info`：

- 候选模式合理，但缺订单结构证据。
- 候选模式合理，但缺复购或利润逻辑。
- 候选模式合理，但缺交付能力证据。
- 缺 SKU / 成交数据时，不能写成最终经营决策。

## 边界

不要输出：

- 最终经营定位。
- 买家 JTBD。
- 差异化口号。
- 阿里国际站 7 屏 brief。
- 经营罗盘最终质检。
