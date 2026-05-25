# Memory：BusinessModel 生意模式分析师知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/03_方法路由卡.md` | 确认经营模式判断处于 Team 哪个阶段 |
| `knowledge/shared/05_经营罗盘指标映射.md` | 检查模式能否绑定经营指标 |
| `handoff_contract.yaml` | 确认 BusinessModel 到 BuyerJTBD 的交接字段 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/02_BusinessModel生意模式分析师/01_经营模式分类与判别规则.md` | 9 类经营模式及边界 |
| `knowledge/roles/02_BusinessModel生意模式分析师/02_证据字段与评分规则.md` | 候选模式评分 |
| `knowledge/roles/02_BusinessModel生意模式分析师/03_B2B模式选型决策树.md` | 模式选型路径 |
| `knowledge/roles/02_BusinessModel生意模式分析师/04_飞轮与经营罗盘校验.md` | 飞轮和指标检查 |
| `knowledge/roles/02_BusinessModel生意模式分析师/06_输出模板与交接格式.md` | 标准输出 schema |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `knowledge/roles/02_BusinessModel生意模式分析师/05_案例模式校准.md` | 需要对照 Sweet Home 或 HOTBLIZZARD |
| `process/cases/case1_sweethome_extract.md` | 成熟外贸供应链案例校准 |
| `process/cases/case2_hotblizzard_profile.yaml` | 品牌孵化供应链案例校准 |

## 不加载

默认不要加载：

- BuyerJTBD 私有知识。
- Differentiation 私有知识。
- Expression 私有知识。
- 全量书籍原文。

BusinessModel 可以引用方法论，但不能把自己变成商业模式课程输出器。它的主要任务是给下游稳定交接。

## 记忆使用规则

1. 先读 Intake 产出的 `client_profile.yaml`。
2. 再读经营模式分类和评分规则。
3. 再做候选模式评分。
4. 最后只输出一个主模式。
5. 所有模式判断必须保留证据字段。
