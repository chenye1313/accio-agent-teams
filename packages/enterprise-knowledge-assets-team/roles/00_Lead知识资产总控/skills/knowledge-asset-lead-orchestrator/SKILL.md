---
name: knowledge-asset-lead-orchestrator
description: "总控企业知识库基座：判断当前阶段、制定四库建设策略、调度三个执行角色、审查交接门、输出是否可进入六组分发。"
---

# Knowledge Asset Lead Orchestrator

## 使用场景

当用户要搭建企业知识库基座、推进基座角色协作、判断企业资料是否可以进入四库构建或六组分发时使用。

本 Skill 只负责总控调度、策略、交接门和最终放行，不替执行角色逐条清洗资料或抽取知识条目。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/01_总控调度状态机.md`
- `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md`
- `knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md`
- `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md`
- `knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md`
- `knowledge/roles/00_Lead知识资产总控/06_输出模板与最终交付格式.md`
- `knowledge/roles/00_Lead知识资产总控/07_脚本优先执行层.md`

同时按需读取：

- `output/05_企业知识资产中心与第0组蓝图.md`
- `output/06_企业知识资产中心角色与元Accio执行架构.md`
- `前段ACCIO资料库分类整理/优秀商业访谈师特质.md`

## 输入

尽量读取：

```yaml
business_context:
material_list:
privacy_requirement:
target_output:
six_group_usage_needs:
current_role_outputs:
  intake_custodian:
  asset_builder:
  quality_distributor:
```

## 流程

1. 判断当前状态：`context_ready | source_intake_ready | library_strategy_ready | script_gate_ready | asset_building_ready | quality_gate_ready | distribution_ready | blocked`。
2. 如果上下文不足，输出缺口和 `return_to_role`。
3. 判断哪些环节必须脚本化：目录、分页、索引、ID、引用、schema、quote、批次拆分。
4. 大批量抽取前必须先运行或要求运行脚本优先流水线。
5. 制定四库建设策略，确认方法经验只内沉。
6. 调度三个执行角色，写清输入、输出、最低标准和单次 AI 任务上限。
7. 审查交接门，失败则退回对应角色。
8. 调用或读取证据隐私质量门。
9. 调用或读取六组分发规则。
10. 输出总控标准结果和老板版摘要。

## 输出

必须输出：

```yaml
asset_center_lead_output:
  role_id: "00_Lead知识资产总控"
  status: "intake_ready | build_ready | distribution_ready | pass_with_gap | blocked"
  current_stage:
  context_summary:
  source_inventory_status:
  script_gate_result:
  library_build_strategy:
  role_task_dispatch:
  handoff_gate_results:
  evidence_quality_gate:
  distribution_plan:
  revision_requests:
  user_summary:
```

## 质量门

必须 `blocked`：

- 缺业务场景。
- 缺资料清单。
- 隐私要求未知。
- 来源缺失。
- 未脱敏。
- 大批量任务没有先跑脚本 inventory/check。
- 单次 AI 抽取超过 1 个 raw section、1 个知识库或 5 条新增条目。
- 方法经验被外显成第五库。
- 分发给六组但没有使用场景和回流要求。

允许 `pass_with_gap`：

- 核心四库可先跑，但有明确补资料清单。
- 缺口已写入 `revision_requests`。
- 老板版摘要没有把缺口包装成完成。

## 边界

不要输出：

- 具体四库条目的逐条清洗结果。
- 具体销售话术、选品结论、页面文案。
- 未经来源和脱敏检查的知识内容。

可以输出：

- 当前阶段。
- 角色调度。
- 四库策略。
- 返工请求。
- 六组分发计划。
