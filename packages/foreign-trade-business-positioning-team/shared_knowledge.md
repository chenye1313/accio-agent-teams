# Shared Knowledge：外贸经营定位专家 Team

## 装配原则

本 Team 不是 8 个角色全部共享一个大知识库，而是：

```text
共享底座 + 角色私有知识切片 + 案例记忆 + 深读材料按需追溯
```

完整装配表见：

- `agent-ready/Teams/外贸经营定位专家Team/knowledge_load_plan.md`
- `agent-ready/Teams/外贸经营定位专家Team/knowledge_mount.yaml`

## 必加载知识库

| 文件 | 用途 |
|---|---|
| `knowledge-base/经营定位/01_能力问题与验收.md` | 能力问题、红线、评分 |
| `knowledge-base/经营定位/02_输入字段_schema.md` | 输入字段、最小 12 字段、访谈追问 |
| `knowledge-base/经营定位/cards_index.yaml` | M00-M07 方法路由 |
| `knowledge-base/经营定位/04_经营定位报告模板.md` | 报告结构 |
| `knowledge-base/经营罗盘/00_指标库.md` | 指标影响与复盘周期 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/02_输入字段与完整度.md` | 经营数据字段、数据成熟度、脱敏规则 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/03_方法路由卡.md` | 含 BP_M00.5 的新版方法路由 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 决策证据充分性、输出降级规则 |

## 案例知识

| 文件 | 用途 |
|---|---|
| `process/cases/case1_sweethome_extract.md` | 成熟输出样例，尤其是 7 屏表达 |
| `process/cases/case2_hotblizzard_profile.yaml` | 输入表样例 |
| `output/经营定位专家小闭环/case2_business_positioning_report.md` | P0 演示报告 |
| `tests/case2_hotblizzard_replay.md` | Case 2 验收标准 |
| `agent-ready/Teams/外贸经营定位专家Team/tests/sweethome_data_upgrade_replay.md` | Sweet Home 数据化升级回放验收 |

## 方法论知识

| 文件 | 用途 |
|---|---|
| `process/deep-review/02_书籍深读第一轮_经营定位映射.md` | 逐书在经营定位中的位置 |
| `process/deep-review/03_Acciowork外贸Agent_PDF审阅.md` | 外贸 Agent、经营罗盘、Skill 结构 |

## 使用规则

- Intake 和 Expression 可以更偏助手协作。
- BusinessModel、BuyerJTBD、SupplyMapping、Differentiation、Lead 必须保持专家判断。
- 所有角色都必须引用客户输入或案例证据。
- 缺证据时标注待补，不得硬写确定结论。
- 只有公开资料时只能输出假设版，不得写成经营决策。
- 自有后台、询盘、成交、SKU 数据优先于公开竞品资料。
- 每个角色优先读取自己的 `must_load` 清单，只有遇到冲突、缺证据或需要追溯时才读取 `on_demand` 材料。
