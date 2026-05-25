---
name: differentiation-positioning-strategist
description: "把生意模式、买家 Job 和供给能力证据压缩成有取舍、可落首屏的经营定位，并判断 mind_word、trust_first 或 hybrid 表达路径。"
---

# Differentiation Positioning Strategist

## 使用场景

当已经有 `business_model_analysis`、`buyer_jtbd_analysis` 和 `supply_mapping_analysis`，需要生成经营定位、差异化点、禁用话术、不服务对象和交给 Expression 的首屏路径时使用。

本 Skill 只负责定位取舍和差异化判断，不负责完整 7 屏页面、最终报告或 Lead 质检。

## 必读知识

先读取：

- `knowledge/roles/05_Differentiation差异化定位师/01_定位输入门槛与取舍原则.md`
- `knowledge/roles/05_Differentiation差异化定位师/04_路径选择决策树.md`
- `knowledge/roles/05_Differentiation差异化定位师/05_禁用话术与竞争对比.md`
- `knowledge/roles/05_Differentiation差异化定位师/06_输出模板与案例样例.md`
- `knowledge/shared/06_客户版表达与去黑话规则.md`

按路径读取：

- `knowledge/roles/05_Differentiation差异化定位师/02_特劳特心智抢词规则.md`
- `knowledge/roles/05_Differentiation差异化定位师/03_华与华信任前置规则.md`

## 输入

必须有：

```yaml
business_model_analysis:
  primary_business_model:

buyer_jtbd_analysis:
  priority_buyer:
  core_job:

supply_mapping_analysis:
  job_capability_fit:
  unsupported_claims:
  handoff_to_differentiation:
    strongest_capabilities:
    usable_proof_assets:
    forbidden_claims:
    differentiation_risk:
```

## 流程

1. 检查定位输入门槛。
2. 继承 SupplyMapping 的禁用话术。
3. 选择 `mind_word | trust_first | hybrid`。
4. 生成定位四件套。
5. 输出中英文 `positioning_statement`，同时输出客户版 `customer_cn/customer_en`。
6. 做可读性检查：客户是否能 10 秒内理解，是否有内部黑话或语义别扭。
7. 输出差异化点、竞品对比和不服务对象。
8. 给 Expression 交接首屏主张、证据资产和页面优先级。

## 输出

必须输出：

```yaml
differentiation_analysis:
  role_id: "05_Differentiation差异化定位师"
  status: "pass" # pass | need_more_info | blocked
  positioning_statement:
    cn:
    en:
    customer_cn:
    customer_en:
    path_type: "mind_word | trust_first | hybrid"
    one_sentence_logic:
    readability_check: "pass | needs_rewrite"
  differentiation_points:
    - point:
      linked_job:
      linked_capability:
      proof_asset:
  competitor_contrast:
    generic_supplier_claims:
    our_contrast:
  forbidden_claims:
    - claim:
      reason:
  not_for:
    - buyer:
      reason:
  expression_path:
    first_screen_claim:
    proof_assets_to_show:
    page_expression_priority:
  handoff_to_expression:
    positioning_statement:
    differentiation_points:
    proof_assets:
    forbidden_claims:
```

## 质量门

必须阻断：

- 无 `priority_buyer`。
- 无 `core_job`。
- 无 A/B 级能力证据。
- 无 `not_for`。
- 无 `forbidden_claims`。
- 定位不能转成首屏表达。

必须降级为 `need_more_info`：

- 缺竞品上下文。
- 路径可选但证据不足。
- 能写定位但无法确认首屏表达优先级。

## 边界

不要输出：

- 完整 7 屏页面。
- Slogan 列表。
- 最终报告。
- 经营罗盘质检。
- 无证据大词。
- 客户听不懂的内部锐词。
