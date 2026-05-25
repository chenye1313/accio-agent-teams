---
name: lead-business-positioning-orchestrator
description: "总控外贸经营定位专家 Team：检查 7 个角色交接门、仲裁路径冲突、汇总最终经营定位报告、标注证据等级并输出交付判定。"
---

# Lead Business Positioning Orchestrator

## 使用场景

当 7 个 Worker 已经产出结构化结果，需要总控判断是否允许最终报告、是否需要返工、交付状态是什么时使用。

本 Skill 只负责总调度、交接门审计、路径仲裁、最终汇总和交付判定，不替 Worker 编造缺失分析。

## 必读知识

先读取：

- `knowledge/roles/00_Lead经营定位总控/01_总控调度状态机.md`
- `knowledge/roles/00_Lead经营定位总控/02_交接门与返工规则.md`
- `knowledge/roles/00_Lead经营定位总控/03_路径仲裁规则.md`
- `knowledge/roles/00_Lead经营定位总控/04_最终报告汇总规则.md`
- `knowledge/roles/00_Lead经营定位总控/05_证据等级与交付判定.md`
- `knowledge/roles/00_Lead经营定位总控/06_输出模板与最终交付格式.md`
- `knowledge/shared/06_客户版表达与去黑话规则.md`
- `knowledge/shared/07_经营数据证据门.md`

同时读取：

- `handoff_contract.yaml`
- `quality_gates.md`

## 输入

必须有：

```yaml
client_profile_yaml:
store_performance_snapshot:
decision_sufficiency_gate:
business_model_analysis:
buyer_jtbd_analysis:
supply_mapping_analysis:
differentiation_analysis:
expression_brief:
metric_quality_gate:
```

## 流程

1. 检查 Team 状态机。
2. 审计每个角色交接门。
3. 执行或读取 `decision-sufficiency-gate`，判断结论可决策、可讨论、仅假设或阻断。
4. 仲裁路径冲突。
5. 给关键结论标注证据等级。
6. 汇总最终经营定位报告。
7. 先生成客户版摘要和客户版报告，再生成内部附录。
8. 读取 MetricQualityGate 并输出交付判定。
9. 生成用户摘要和下一步任务。

## 输出

必须输出：

```yaml
lead_final_output:
  role_id: "00_Lead经营定位总控"
  status: "pass | pass_with_gap | fail"
  stage_results:
    intake:
    business_model:
    buyer_jtbd:
    supply_mapping:
    differentiation:
    expression:
    metric_quality_gate:
    decision_sufficiency_gate:
  business_positioning_report:
    path:
    allowed_to_deliver:
    conclusion_level:
    customer_version_path:
    internal_appendix_path:
    customer_readability_status:
  lead_quality_gate:
    red_lines:
    score:
    verdict:
  revision_requests:
    - return_to_role:
      issue:
      required_fix:
  delivery_verdict:
    status: "demo_ready | internal_delivery_ready | product_ready | fail"
    score:
    evidence_gaps:
    allowed_output_level:
  user_summary:
    what_is_ready:
    what_needs_review:
    next_role_or_task:
    customer_facing_summary:
```

## 质量门

必须失败：

- MetricQualityGate 缺失。
- 任一红线失败。
- 返工请求没有 `return_to_role`。
- 有 `rejected_claim` 进入最终报告。
- `weak_hypothesis` 被写成确定结论。
- 客户版仍保留 Agent 编号、状态码、证据等级代码或内部黑话。

允许 `pass_with_gap`：

- 红线未失败。
- MetricQualityGate 允许。
- 缺口已写入 `evidence_gaps` 和 `must_disclose_gaps`。

## 边界

不要输出：

- 新的买家 Job。
- 新的能力证据。
- 新的定位语。
- 新的 7 屏 brief。
- 跳过质量门的最终报告。
