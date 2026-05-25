# Memory：BuyerJTBD 买家任务分析师知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/03_方法路由卡.md` | 确认 JTBD 位于生意模式之后、供给映射之前 |
| `knowledge/shared/02_输入字段与完整度.md` | 检查目标买家、买家痛点和成功指标字段 |
| `handoff_contract.yaml` | 确认 BuyerJTBD 到 SupplyMapping 的交接字段 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/03_BuyerJTBD买家任务分析师/01_JTBD核心定义与禁忌.md` | Job 定义、三层 Job、禁用写法 |
| `knowledge/roles/03_BuyerJTBD买家任务分析师/02_B2B多角色采购任务拆解.md` | B2B 采购委员会和角色冲突 |
| `knowledge/roles/03_BuyerJTBD买家任务分析师/03_成功指标DesiredOutcomes构造规则.md` | Desired Outcomes 句式、分类和交接 |
| `knowledge/roles/03_BuyerJTBD买家任务分析师/06_输出模板与交接格式.md` | 标准输出 schema |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `knowledge/roles/03_BuyerJTBD买家任务分析师/04_访谈与追问脚本.md` | 缺采购情境、替代方案、雇用/解雇标准 |
| `knowledge/roles/03_BuyerJTBD买家任务分析师/05_案例JTBD校准.md` | 需要对照 Sweet Home 或 HOTBLIZZARD 校准 Job |
| `process/cases/case1_sweethome_extract.md` | 项目解决方案型客户校准 |
| `process/cases/case2_hotblizzard_profile.yaml` | 品牌孵化供应链型客户校准 |

## 不加载

默认不要加载：

- SupplyMapping 私有知识。
- Differentiation 私有知识。
- Expression 私有知识。
- 全量书籍原文。

BuyerJTBD 可以标出“需要哪些能力”，但不能判断企业是否具备这些能力；这交给 SupplyMapping。

## 记忆使用规则

1. 先读取 BusinessModel 的 `business_model_analysis`。
2. 再读取 JTBD 核心定义和 B2B 多角色采购规则。
3. 先拆买家角色，再写核心 Job。
4. 先写 Desired Outcomes，再写能力关键词。
5. 输出必须让 SupplyMapping 能逐项匹配能力证据。
