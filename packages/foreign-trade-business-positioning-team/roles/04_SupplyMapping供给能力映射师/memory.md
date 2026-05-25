# Memory：SupplyMapping 供给能力映射师知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/02_输入字段与完整度.md` | 查找能力字段和证据字段 |
| `knowledge/shared/03_方法路由卡.md` | 确认 SupplyMapping 位于 JTBD 之后、Differentiation 之前 |
| `handoff_contract.yaml` | 确认 SupplyMapping 到 Differentiation 的交接字段 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/04_SupplyMapping供给能力映射师/01_能力证据分级规则.md` | 能力类型、证据等级、同行通用卖点过滤 |
| `knowledge/roles/04_SupplyMapping供给能力映射师/02_Job到能力映射表.md` | Desired Outcome 到企业能力映射 |
| `knowledge/roles/04_SupplyMapping供给能力映射师/03_证据缺口与补问规则.md` | 缺口类型、补问模板、优先级 |
| `knowledge/roles/04_SupplyMapping供给能力映射师/05_输出模板与交接格式.md` | 标准输出 schema |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `knowledge/roles/04_SupplyMapping供给能力映射师/04_案例能力校准.md` | 需要对照 Sweet Home 或 HOTBLIZZARD 校准 |
| `process/cases/case1_sweethome_extract.md` | 项目解决方案型能力映射 |
| `process/cases/case2_hotblizzard_profile.yaml` | 品牌孵化供应链型能力映射 |
| `process/deep-review/03_Acciowork外贸Agent_PDF审阅.md` | 需要参考外贸 Agent 知识库缺口 |

## 不加载

默认不要加载：

- Differentiation 私有知识。
- Expression 私有知识。
- Lead 总控私有知识。
- 全量书籍原文。

SupplyMapping 只验证能力与证据，不写定位语。

## 记忆使用规则

1. 先读取 BuyerJTBD 的 `buyer_jtbd_analysis`。
2. 再读取 Intake 的 `client_profile.yaml` 能力字段。
3. 对每个 Desired Outcome 建立能力映射。
4. 对每个能力证据打 A/B/C/D 等级。
5. 只把 A/B 级能力交给 Differentiation 作为核心优势候选。
