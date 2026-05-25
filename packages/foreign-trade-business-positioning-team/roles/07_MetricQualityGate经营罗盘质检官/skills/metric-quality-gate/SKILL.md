---
name: metric-quality-gate
description: "把经营定位和页面表达绑定到经营罗盘指标，执行六条红线、评分、pass/pass_with_gap/fail 判定和返工路由。"
---

# Metric Quality Gate

## 使用场景

当已经有经营定位、差异化点和 7 屏表达 brief，需要判断是否允许交给 Lead 汇总最终报告时使用。

本 Skill 只负责经营指标绑定、红线质检、评分和返工路由，不负责写新定位或页面文案。

## 必读知识

先读取：

- `knowledge/roles/07_MetricQualityGate经营罗盘质检官/01_经营罗盘指标与定位动作映射.md`
- `knowledge/roles/07_MetricQualityGate经营罗盘质检官/02_红线质检与评分规则.md`
- `knowledge/roles/07_MetricQualityGate经营罗盘质检官/03_复盘周期与返工路由.md`
- `knowledge/roles/07_MetricQualityGate经营罗盘质检官/05_输出模板与交接格式.md`
- `knowledge/shared/05_经营罗盘指标映射.md`
- `knowledge/shared/07_经营数据证据门.md`

按需读取：

- `knowledge/roles/07_MetricQualityGate经营罗盘质检官/04_案例回放验收规则.md`

## 输入

必须有：

```yaml
positioning_statement:
differentiation_points:
seven_screen_brief:
evidence_sources:
store_performance_snapshot:
baseline_metrics:
post_launch_metrics:
handoff_to_metric_quality_gate:
```

## 流程

1. 检查输出完整度。
2. 建立上线前基线，缺基线时标注观察指标。
3. 将定位动作映射到经营罗盘指标。
4. 生成 7 天、30 天、90 天复盘节奏。
5. 执行六条红线。
6. 按评分维度评分。
7. 判定 `pass | pass_with_gap | fail`。
8. 生成返工请求。
9. 给 Lead 交接是否允许最终报告。

## 输出

必须输出：

```yaml
metric_quality_gate:
  role_id: "07_MetricQualityGate经营罗盘质检官"
  status: "pass | pass_with_gap | fail"
  metric_impact_table:
    - positioning_action:
      expected_metrics:
      validation_cycle:
      review_layer_if_no_improvement:
  baseline_metrics:
  first_7_day_check:
  first_30_day_metric:
  first_90_day_metric:
  lead_quality_gate:
    red_lines:
    score:
    verdict:
  revision_requests:
    - failed_gate:
      return_to_role:
      issue:
      required_fix:
      evidence_needed:
  handoff_to_lead:
    pass_fail:
    final_report_allowed:
    summary:
    must_disclose_gaps:
```

## 质量门

必须失败：

- 任一红线失败。
- 总分低于 70。
- 没有指标影响。
- 没有返工角色。
- 没有上线前基线却承诺提升比例。

允许 `pass_with_gap`：

- 红线未失败。
- 总分 >= 70。
- 存在案例、授权或后台数据缺口。
- 缺口已写入 `must_disclose_gaps`。

## 边界

不要输出：

- 新定位。
- 新 7 屏 brief。
- 无返工角色的建议。
- 隐瞒缺口的 `pass`。
