# Agents：BusinessModel 内部调度

BusinessModel 对外是一个 Agent，对内按 5 个子模块执行。

## B01 Mode Candidate Scanner

职责：

- 读取 `client_profile.yaml`。
- 识别当前经营模式线索。
- 生成 2-4 个候选模式，不直接下最终结论。

输入：

- `current_business_model`
- `target_buyer_types`
- `priority_buyer`
- `main_order_type`
- `customization_services`
- `rd_capabilities`
- `capacity`
- `sku_performance_map`
- `store_performance_snapshot`

输出：

- `candidate_models`
- `candidate_reasons`

## B01.5 SKU Performance Mapper

职责：

- 读取 `sku_performance_map` 或调用 `sku-performance-mapper`。
- 识别主推产品、询盘产品、成交产品、利润产品和弱化产品。
- 判断老板想推的产品与市场真实反馈是否一致。

输出：

- `sku_business_implication`
- `product_positioning_recommendation`
- `sku_data_gaps`

## B02 Evidence Scorer

职责：

- 按 `02_证据字段与评分规则.md` 给候选模式评分。
- 判断每个候选模式的买家证据、订单证据、能力证据和复购逻辑。

输出：

- `model_scores`
- `model_evidence`
- `missing_evidence`

## B03 Primary Model Decider

职责：

- 选出唯一主模式。
- 识别辅模式。
- 标记不适合模式。
- 检查主模式是否能形成经营飞轮。

输出：

- `primary_business_model`
- `secondary_business_models`
- `unsuitable_models`
- `flywheel_check`

## B04 Handoff Builder

职责：

- 生成 `business_model_analysis`。
- 给 `03_BuyerJTBD买家任务分析师` 交接买家方向和待验证假设。
- 如果证据不足，生成退回 Intake 的补问字段。

输出：

- `business_model_analysis`
- `handoff_to_buyer_jtbd`
- `missing_fields`

## 调用顺序

```text
B01 Mode Candidate Scanner
  -> B01.5 SKU Performance Mapper
  -> B02 Evidence Scorer
  -> B03 Primary Model Decider
  -> B04 Handoff Builder
```

## 状态规则

```yaml
status:
  pass: "主模式明确，SKU / 订单 / 能力证据足够，进入 BuyerJTBD"
  need_more_info: "候选模式存在，但关键证据不足，退回 Intake 补问"
  blocked: "缺目标买家、订单类型或能力证据，禁止进入后续定位"
```
