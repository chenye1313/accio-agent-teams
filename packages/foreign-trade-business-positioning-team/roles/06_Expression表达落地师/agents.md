# Agents：Expression 内部调度

Expression 对外是一个 Agent，对内按 5 个子模块执行。

## E01 Expression Input Gate

职责：

- 读取 `differentiation_analysis`。
- 检查定位、差异化点、证据资产和禁用话术是否齐全。
- 确认不能使用的 claims。

输出：

- `expression_inputs_ready`
- `blocked_claims`
- `proof_assets_ready`

## E02 Language Pin Builder

职责：

- 先生成客户版首屏主句，再生成语言钉子和 headline 候选。
- 确保语言钉子承接定位，不变成空泛 slogan 或内部黑话。
- 对候选做 10 秒可读性检查，语义别扭的表达只保留为内部草稿。

输出：

- `slogan_options`
- `first_screen_claim`
- `readability_check`

## E03 Visual Hammer Planner

职责：

- 根据定位路径设计视觉锤方向。
- 标明需要哪些图片、流程图、案例图、认证图或视频素材。

输出：

- `visual_hammer`
- `assets_needed`
- `content_asset_gaps`

## E04 Seven Screen Brief Composer

职责：

- 按 `02_阿里国际站7屏Brief模板.md` 生成 7 屏 brief。
- 每屏必须绑定买家决策和成本降低。

输出：

- `seven_screen_brief`

## E05 Trust CTA and Metric Handoff Builder

职责：

- 组织信任资产展示边界。
- 生成 CTA。
- 给 MetricQualityGate 交接表达动作和预期指标影响。

输出：

- `trust_proofs`
- `cta`
- `handoff_to_metric_quality_gate`

## 调用顺序

```text
E01 Expression Input Gate
  -> E02 Language Pin Builder
  -> E03 Visual Hammer Planner
  -> E04 Seven Screen Brief Composer
  -> E05 Trust CTA and Metric Handoff Builder
```

## 状态规则

```yaml
status:
  pass: "7 屏完整，证据资产可标注，CTA 可承接询盘，进入 MetricQualityGate"
  need_more_info: "7 屏可写但缺素材或授权，标注素材缺口后进入质检"
  blocked: "无定位、无证据、无首屏表达，退回 Differentiation 或 SupplyMapping"
```

## 内置自检

```yaml
expression_self_check:
  has_positioning_statement: true
  has_seven_screens: true
  every_screen_has_cost_reduced: true
  every_screen_has_target_buyer_decision: true
  cta_not_contact_us_only: true
  trust_assets_have_source_or_auth_status: true
  first_screen_customer_readable: true
```
