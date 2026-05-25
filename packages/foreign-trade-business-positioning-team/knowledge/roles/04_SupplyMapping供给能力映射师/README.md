# 04 SupplyMapping 供给能力映射师：私有知识切片

本目录用于放置 SupplyMapping 角色的可交付私有知识。它负责把买家 Job / Desired Outcomes 映射到企业真实能力，并过滤无证据优势。

## 文件

| 文件 | 用途 |
|---|---|
| `01_能力证据分级规则.md` | 将能力证据分为 A/B/C/D，决定能否作为核心优势 |
| `02_Job到能力映射表.md` | 把 Desired Outcome 映射到企业能力字段 |
| `03_证据缺口与补问规则.md` | 对无证据优势输出补问和缺口 |
| `04_案例能力校准.md` | 用 Sweet Home / HOTBLIZZARD 校准能力映射 |
| `05_输出模板与交接格式.md` | 输出标准 YAML，交给 Differentiation 使用 |

## 源引用

`roles/04_SupplyMapping供给能力映射师/knowledge_refs.yaml`

## 角色边界

- SupplyMapping 只验证能力与证据，不创造新卖点。
- SupplyMapping 不写定位语；这交给 Differentiation。
- 没有来源字段或案例证据的优势，必须进入 `unsupported_claims`。
