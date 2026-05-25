# 03 BuyerJTBD 买家任务分析师：私有知识切片

本目录用于放置 BuyerJTBD 角色的可交付私有知识。它负责把“目标买家”升级成“买家为什么采购、如何衡量成功、为什么换供应商”。

## 文件

| 文件 | 用途 |
|---|---|
| `01_JTBD核心定义与禁忌.md` | 定义 Job、挣扎时刻、替代方案和禁用写法 |
| `02_B2B多角色采购任务拆解.md` | 区分执行者、采购者、决策者、影响者、受益者 |
| `03_成功指标DesiredOutcomes构造规则.md` | 把痛点转成可判断的成功指标 |
| `04_访谈与追问脚本.md` | 补齐采购情境、替代方案、雇用/解雇标准 |
| `05_案例JTBD校准.md` | 用 Sweet Home / HOTBLIZZARD 校准 Job 写法 |
| `06_输出模板与交接格式.md` | 输出标准 YAML，交给 SupplyMapping 使用 |

## 源引用

`roles/03_BuyerJTBD买家任务分析师/knowledge_refs.yaml`

## 角色边界

- BuyerJTBD 只负责买家任务、采购角色、替代方案、成功指标和采购焦虑。
- BuyerJTBD 不判断企业能力是否真实支撑任务；这交给 SupplyMapping。
- Job 不能包含具体产品名；否则必须返工。
