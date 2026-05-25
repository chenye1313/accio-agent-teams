# Agents：BuyerJTBD 内部调度

BuyerJTBD 对外是一个 Agent，对内按 6 个子模块执行。

## J01 Buyer Context Resolver

职责：

- 读取 `business_model_analysis` 和 `client_profile.yaml`。
- 确认 `priority_buyer`、买家阶段、主生意模式和订单类型。
- 判断是否具备进入 JTBD 分析的最低信息。

输入：

- `primary_business_model`
- `priority_buyer`
- `buyer_stage`
- `main_products`
- `main_order_type`
- `buyer_pain_points_known`
- `buyer_success_metrics_known`
- `inquiry_buyer_segments`

输出：

- `buyer_context`
- `status_precheck`
- `missing_context_fields`

## J01.5 Inquiry Sales Segmenter

职责：

- 读取 `inquiry_buyer_segments` 或调用 `inquiry-sales-segmenter`。
- 用真实询盘、报价状态和成交结果校准 A 类买家。
- 标注买家判断置信度和错配风险。

输出：

- `buyer_segment_confidence`
- `recommended_priority_buyer`
- `mismatch_warning`

## J02 B2B Buying Committee Mapper

职责：

- 按 `02_B2B多角色采购任务拆解.md` 拆采购委员会。
- 区分 Job Executor、Purchaser、Decision Maker、Influencer、Beneficiary。
- 标记角色冲突，例如采购要低价、老板要低风险、设计师要效果。

输出：

- `buyer_roles`
- `role_conflicts`
- `decision_priority`

## J03 Core Job Constructor

职责：

- 按 `01_JTBD核心定义与禁忌.md` 构造非产品名 Job。
- 写出 Functional / Emotional / Social 三层 Job。
- 检查 Job 是否包含情境、阻力和进步。

输出：

- `core_job`
- `struggling_moment`
- `current_workaround`
- `forbidden_product_words_checked`

## J04 Desired Outcomes Engineer

职责：

- 把痛点转成成功指标。
- 至少输出 3 个 Desired Outcomes。
- 每个指标必须标注 `outcome_type` 和需要的能力关键词。

输出：

- `desired_outcomes`
- `unsupported_or_uncertain`

## J05 Hire/Fire Criteria and Handoff Builder

职责：

- 输出采购焦虑、雇用标准和解雇标准。
- 生成 `buyer_jtbd_analysis`。
- 给 SupplyMapping 交接核心 Job、成功指标和能力关键词。

输出：

- `purchase_anxiety`
- `hire_criteria`
- `fire_criteria`
- `handoff_to_supply_mapping`

## 调用顺序

```text
J01 Buyer Context Resolver
  -> J01.5 Inquiry Sales Segmenter
  -> J02 B2B Buying Committee Mapper
  -> J03 Core Job Constructor
  -> J04 Desired Outcomes Engineer
  -> J05 Hire/Fire Criteria and Handoff Builder
```

## 状态规则

```yaml
status:
  pass: "Job、角色、替代方案、成功指标、雇用/解雇标准清楚，进入 SupplyMapping"
  need_more_info: "有目标买家，但缺采购情境、替代方案或成功指标，退回 Intake 补问"
  blocked: "优先买家不清、Job 含产品名、Desired Outcomes 不足 3 个，禁止进入后续定位"
```

## 内置自检

输出前必须做一次自检：

```yaml
jtbd_self_check:
  job_contains_product_name: false
  desired_outcomes_count: 3
  has_job_executor: true
  has_decision_maker: true
  has_current_workaround: true
  has_hire_criteria: true
  has_fire_criteria: true
  buyer_source_marked: true
```
