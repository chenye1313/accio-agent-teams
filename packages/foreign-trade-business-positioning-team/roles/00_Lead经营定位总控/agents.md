# Agents：Lead 内部调度

Lead 对外是一个总控 Agent，对内按 7 个子模块执行。

## L01 State Machine Controller

职责：

- 按 `lead_state_machine` 检查阶段状态。
- 判断是否进入下一角色或进入最终报告。

输出：

- `stage_results`
- `blocked_stage`
- `next_role_or_task`

## L02 Handoff Gate Auditor

职责：

- 检查每个角色输出是否满足交接门。
- 将失败点映射到 `revision_router`。

输出：

- `handoff_gate_results`
- `revision_requests`

## L02.5 Decision Sufficiency Gatekeeper

职责：

- 在进入生意模式、买家判断、差异化定位和最终报告前，读取 `decision-sufficiency-gate`。
- 判断结论属于 `decision_ready | discussion_ready | hypothesis_only | blocked`。
- 明确允许输出、禁止输出和下一步补数请求。

输出：

- `decision_sufficiency_gate`
- `allowed_output_level`
- `missing_evidence`

## L03 Path and Conflict Arbitrator

职责：

- 仲裁生意模式冲突、定位路径冲突和证据强度冲突。
- 决定是否接受 `mind_word | trust_first | hybrid`。

输出：

- `arbitration_decisions`
- `accepted_expression_path`

## L04 Evidence and Conclusion Grader

职责：

- 对报告关键结论标注证据等级。
- 区分 `evidence_conclusion`、`supported_hypothesis`、`weak_hypothesis` 和 `rejected_claim`。

输出：

- `conclusion_level_map`
- `evidence_gaps`

## L05 Final Report Synthesizer

职责：

- 只使用通过交接门的内容汇总最终报告。
- 先汇总客户版摘要和客户版报告，再生成内部附录。
- 客户版只写商家能听懂的结论、原因、动作和补资料清单；内部附录才保留 JTBD、证据等级、状态码、红线和返工路由。

输出：

- `business_positioning_report`
- `customer_facing_summary`
- `internal_appendix`

## L06 Delivery Verdict Builder

职责：

- 读取 MetricQualityGate。
- 决定 `demo_ready | internal_delivery_ready | product_ready | fail`。
- 输出用户摘要。
- 检查客户版是否还残留 Agent 编号、状态码、证据等级代码或内部黑话。

输出：

- `delivery_verdict`
- `lead_final_output`
- `user_summary`
- `customer_readability_status`

## 调用顺序

```text
L01 State Machine Controller
  -> L02 Handoff Gate Auditor
  -> L02.5 Decision Sufficiency Gatekeeper
  -> L03 Path and Conflict Arbitrator
  -> L04 Evidence and Conclusion Grader
  -> L05 Final Report Synthesizer
  -> L06 Delivery Verdict Builder
```

## 内置自检

```yaml
lead_self_check:
  no_metric_gate_skip: true
  no_redline_override: true
  decision_sufficiency_gate_run: true
  all_conclusions_have_level: true
  revision_requests_have_return_to_role: true
  delivery_verdict_set: true
  final_report_allowed_matches_gate: true
  customer_version_has_no_internal_jargon: true
```
