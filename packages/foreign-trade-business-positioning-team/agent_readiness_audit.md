# Agent Readiness Audit：外贸经营定位专家 Team

审计时间：2026-05-19

## 结论

审计启动时，Team 只完成了“8 个角色的知识底座”，不是“8 个 Agent 全部完成”。截至本轮 Agent 化完成后，8 个角色均已补齐五文件与至少 1 个 Skill。

已经完成：

- Team 共享知识库：`knowledge/shared/`
- 8 个角色私有知识库：`knowledge/roles/*/`
- 8 个角色知识挂载引用：`roles/*/knowledge_refs.yaml`
- Team 级流程、交接、质量门：`workflow.md`、`handoff_contract.yaml`、`quality_gates.md`

仍未完成：

- 平台真实多 Agent 调度测试。
- 每个角色的端到端案例回放。
- 全队 Case 1 / Case 2 复跑验收。

## 关键判断

上一步的 53 个私有知识文件解决的是“每个角色应该知道什么”。但 Agent 能否跑起来，还需要解决：

1. `identity.md`：这个角色是谁，边界是什么。
2. `soul.md`：这个角色的底层原则和红线是什么。
3. `agents.md`：这个角色内部怎么拆任务、如何调度。
4. `memory.md`：这个角色具体加载哪些共享知识和私有知识。
5. `user.md`：这个角色如何与用户或上游角色交互。
6. `SKILL.md`：平台或 Codex 何时调用这个角色，输入输出是什么。

所以不能把“知识库齐了”误判成“Agent 齐了”。

## 当前完成度矩阵

| 角色 | 知识库 | Agent 五文件 | Skill | 调度可执行度 | 当前状态 |
|---|---|---|---|---|---|
| 经营定位专家单体包 | 已完成 | 已完成 | 已完成 | P0 可演示 | 已完成 |
| 00 Lead 经营定位总控 | 已完成 | 本轮补齐 | 本轮补齐 | 可总控状态机、交接门、仲裁、汇总与交付判定 | 本轮推进 |
| 01 Intake 资料采集官 | 已完成 | 本轮补齐 | 本轮补齐 | 可作为入口 Agent | 本轮推进 |
| 02 BusinessModel 生意模式分析师 | 已完成 | 本轮补齐 | 本轮补齐 | 可判断主生意模式并交接 JTBD | 本轮推进 |
| 03 BuyerJTBD 买家任务分析师 | 已完成 | 本轮补齐 | 本轮补齐 | 可拆 B2B 采购角色、核心 Job 与 Desired Outcomes | 本轮推进 |
| 04 SupplyMapping 供给能力映射师 | 已完成 | 本轮补齐 | 本轮补齐 | 可映射 Job/Outcome 到能力证据并过滤无证据优势 | 本轮推进 |
| 05 Differentiation 差异化定位师 | 已完成 | 本轮补齐 | 本轮补齐 | 可做定位取舍、路径仲裁与 Expression 交接 | 本轮推进 |
| 06 Expression 表达落地师 | 已完成 | 本轮补齐 | 本轮补齐 | 可生成首屏、7 屏 brief、信任资产和 CTA | 本轮推进 |
| 07 MetricQualityGate 经营罗盘质检官 | 已完成 | 本轮补齐 | 本轮补齐 | 可执行经营指标绑定、红线质检和返工路由 | 本轮推进 |

## 正确推进顺序

不要先做 Lead。Lead 需要读取所有 Worker 的稳定输出格式，否则会变成空泛总控。

推荐顺序：

1. `01_Intake资料采集官`：先做入口，因为后续所有 Agent 都依赖 `client_profile.yaml`。
2. `02_BusinessModel生意模式分析师`：判断做哪盘生意。
3. `03_BuyerJTBD买家任务分析师`：识别 A 类买家与核心 Job。
4. `04_SupplyMapping供给能力映射师`：证明企业凭什么赢。
5. `05_Differentiation差异化定位师`：做取舍和定位表达。
6. `06_Expression表达落地师`：转成阿里 7 屏与信任资产。
7. `07_MetricQualityGate经营罗盘质检官`：指标与红线质检。
8. `00_Lead经营定位总控`：最后汇总，因为它依赖前面 7 个角色的稳定契约。

## 本轮执行范围

本轮先把 `01_Intake资料采集官` 做成真正可装配 Agent：

- 补 `identity.md`
- 补 `soul.md`
- 补 `agents.md`
- 补 `memory.md`
- 补 `user.md`
- 补 `skills/intake-profile-builder/SKILL.md`

完成后进入 `02_BusinessModel生意模式分析师`，补齐主生意模式判断 Agent。
