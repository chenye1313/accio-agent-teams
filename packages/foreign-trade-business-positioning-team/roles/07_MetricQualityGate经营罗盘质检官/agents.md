# Agents：MetricQualityGate 内部调度

MetricQualityGate 对外是一个 Agent，对内按 6 个子模块执行。

## Q01 Output Completeness Scanner

职责：

- 读取前序角色输出。
- 检查是否包含买家、Job、证据、定位、7 屏和指标输入。

输出：

- `completeness_scan`
- `missing_sections`

## Q02 Metric Impact Mapper

职责：

- 把定位动作和表达动作映射到九项经营罗盘指标。
- 输出 30 天先导指标和 60-90 天结果指标。

输出：

- `metric_impact_table`
- `baseline_metrics`
- `first_7_day_check`
- `first_30_day_metric`
- `first_90_day_metric`

## Q02.5 Review Cadence Builder

职责：

- 基于 `store_performance_snapshot` 建立上线前基线。
- 区分 7 天可用性、30 天先导指标、90 天经营结果。
- 没有基线时，禁止写提升承诺，只列观察指标。

输出：

- `baseline_metrics`
- `first_7_day_check`
- `review_cadence`

## Q03 Redline Gate Checker

职责：

- 执行六条红线。
- 红线失败时立即写 `revision_requests`。

输出：

- `lead_quality_gate.red_lines`
- `redline_failed`

## Q04 Score and Verdict Builder

职责：

- 按 7 个维度评分。
- 判定 `pass | pass_with_gap | fail`。
- 确保 `pass_with_gap` 披露缺口。

输出：

- `lead_quality_gate.score`
- `metric_quality_gate.status`
- `verdict`

## Q05 Revision Router and Lead Handoff

职责：

- 生成返工路由。
- 给 Lead 交接是否允许最终报告、必须披露的缺口和摘要。

输出：

- `revision_requests`
- `handoff_to_lead`

## 调用顺序

```text
Q01 Output Completeness Scanner
  -> Q02 Metric Impact Mapper
  -> Q02.5 Review Cadence Builder
  -> Q03 Redline Gate Checker
  -> Q04 Score and Verdict Builder
  -> Q05 Revision Router and Lead Handoff
```

## 内置自检

```yaml
metric_gate_self_check:
  redline_overrides_score: true
  has_metric_impact_table: true
  has_first_30_day_metric: true
  has_first_90_day_metric: true
  no_improvement_claim_without_baseline: true
  has_revision_requests_if_gap_or_fail: true
  pass_with_gap_discloses_gaps: true
```
