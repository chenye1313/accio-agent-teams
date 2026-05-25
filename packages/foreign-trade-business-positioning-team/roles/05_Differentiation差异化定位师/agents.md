# Agents：Differentiation 内部调度

Differentiation 对外是一个 Agent，对内按 5 个子模块执行。

## D01 Positioning Input Gate

职责：

- 读取 `business_model_analysis`、`buyer_jtbd_analysis` 和 `supply_mapping_analysis`。
- 检查进入定位的五项输入是否齐全。
- 过滤 SupplyMapping 标记的 `unsupported_claims`。

输出：

- `positioning_inputs_ready`
- `blocking_fields`
- `usable_capabilities`
- `forbidden_claims_inherited`

## D02 Path Arbitration

职责：

- 按 `04_路径选择决策树.md` 判断路径。
- 在 `mind_word`、`trust_first`、`hybrid` 中选一个主路径。
- 给出路径选择原因。

输出：

- `path_type`
- `path_reason`
- `return_route_if_failed`

## D03 Positioning Core Composer

职责：

- 生成定位四件套。
- 写出内部版和客户版的中英文 `positioning_statement`。
- 确保定位包含买家、Job、能力和经营模式。
- 检查客户是否能 10 秒内理解，避免内部锐词直接外显。

输出：

- `positioning_core`
- `positioning_statement`
- `customer_positioning_statement`
- `one_sentence_logic`
- `readability_check`

## D04 Contrast and Tradeoff Builder

职责：

- 输出竞品通用说法和我方对比。
- 写出 `not_for`。
- 继承并扩展禁用话术。

输出：

- `competitor_contrast`
- `not_for`
- `forbidden_claims`

## D05 Expression Handoff Builder

职责：

- 判断定位是否能落阿里首屏。
- 给 Expression 交接客户版首屏主张、证据资产、页面优先级。

输出：

- `expression_path`
- `handoff_to_expression`

## 调用顺序

```text
D01 Positioning Input Gate
  -> D02 Path Arbitration
  -> D03 Positioning Core Composer
  -> D04 Contrast and Tradeoff Builder
  -> D05 Expression Handoff Builder
```

## 状态规则

```yaml
status:
  pass: "定位四件套齐全，有证据、有取舍、能落首屏，进入 Expression"
  need_more_info: "方向存在，但缺竞品、表达或证据补强信息"
  blocked: "缺买家、Job、A/B 级能力证据或不能说明不服务对象"
```

## 内置自检

```yaml
differentiation_self_check:
  has_priority_buyer: true
  has_core_job: true
  uses_only_supported_capabilities: true
  has_not_for: true
  has_forbidden_claims: true
  can_land_first_screen: true
  not_slogan_only: true
  customer_can_understand_in_10_seconds: true
```
