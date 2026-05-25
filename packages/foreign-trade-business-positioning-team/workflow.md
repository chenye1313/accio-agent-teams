# Workflow：外贸经营定位专家 Team

版本：v0.2

## 主流程

```text
01 Intake 资料采集官
  -> 00 Lead / BP_M00.5 经营数据诊断与决策证据门
  -> 02 BusinessModel 生意模式分析师
  -> 03 BuyerJTBD 买家任务分析师
  -> 04 SupplyMapping 供给能力映射师
  -> 05 Differentiation 差异化定位师
  -> 06 Expression 表达落地师
  -> 07 MetricQualityGate 经营罗盘质检官
  -> 00 Lead 经营定位总控
```

## 三段式运行

### 第一段：经营现状诊断

目标：先看真实经营事实，不先写定位。

输出：

- `client_profile.yaml`
- `store_performance_snapshot.yaml`
- `inquiry_buyer_segments.yaml`
- `sku_performance_map.yaml`
- `decision_sufficiency_gate`

如果只有公开店铺链接，输出必须标为假设版。

### 第二段：经营定位生成

目标：基于数据和证据回答“做哪盘生意、服务谁、凭什么赢、怎么表达”。

输出：

- `business_model_analysis`
- `buyer_jtbd_analysis`
- `supply_mapping_analysis`
- `differentiation_analysis`
- `expression_brief`

### 第三段：经营验证复盘

目标：把定位动作绑定指标，并定义上线后复盘。

输出：

- `baseline_metrics`
- `first_7_day_check`
- `first_30_day_metric`
- `first_90_day_metric`
- `review_layer`

## 返工机制

| 触发点 | 退回角色 | 原因 |
|---|---|---|
| 缺目标买家 | Intake | 无法判断 A 类买家 |
| 只有公开链接却写成决策 | Lead / Intake | 数据成熟度不足 |
| 无后台 / 询盘 / 成交证据 | Lead | 降级为 `hypothesis_only` |
| Job 写成产品名 | BuyerJTBD | 仍是产品卖点，不是采购任务 |
| 差异化无证据 | SupplyMapping | 需要补证据或降级为假设 |
| 竞品资料替代自有数据 | SupplyMapping / Lead | 公开抓取只能作市场参照 |
| 定位过宽 | Differentiation | 没有取舍 |
| 不能转页面 | Expression | 不具备落地表达 |
| 没有指标影响 | MetricQualityGate | 不是经营提效方案 |
| 没有上线前基线却承诺提升 | MetricQualityGate | 指标不可验证 |
| 客户版有内部黑话 | Lead / Expression | 商家读不懂 |
| 红线失败 | Lead | 禁止交付 |

## 最小运行顺序

P0 允许单 Agent 模拟 Team，但必须保留角色输出：

1. Intake 输出字段完整度和数据成熟度。
2. Store Performance Intake 输出店铺经营快照。
3. Lead 执行决策证据充分性判断。
4. BusinessModel 输出主模式，并说明 SKU / 订单证据。
5. BuyerJTBD 输出核心 Job，并说明是否来自真实询盘。
6. SupplyMapping 输出证据表和竞品参照边界。
7. Differentiation 输出一句话定位。
8. Expression 输出 7 屏 brief。
9. MetricQualityGate 输出基线、7/30/90 天指标和红线检查。
10. Lead 汇总客户版报告和内部附录。

