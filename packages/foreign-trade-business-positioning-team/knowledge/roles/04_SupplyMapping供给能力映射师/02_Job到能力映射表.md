# 02 Job 到能力映射表

版本：v0.1  
适用角色：`04_SupplyMapping供给能力映射师`

## 1. 输入

来自 BuyerJTBD：

```yaml
core_job: ""
desired_outcomes: []
purchase_anxiety: []
hire_criteria: []
fire_criteria: []
```

来自 Intake / BusinessModel：

```yaml
main_products: []
product_differentiation: []
customization_services: []
rd_capabilities: []
delivery_cycle: ""
certifications: []
partnerships: []
capacity: ""
case_studies: []
```

## 2. 映射方法

按这个顺序处理：

```text
Desired Outcome
  -> 需要什么能力
  -> 企业现有字段是否支撑
  -> 证据强度
  -> 是否可作为核心优势
```

## 3. 常见映射

| Desired Outcome | 需要的能力 | 可用证据字段 |
|---|---|---|
| 缩短打样周期 | 快速打样、设计协同、样品流程 | `delivery_cycle`、`rd_capabilities` |
| 降低库存风险 | 小单测试、柔性生产、趋势判断 | `main_order_type`、`customization_services`、`product_differentiation` |
| 提高爆款命中率 | 产品策略、数据分析、内容反馈 | `rd_capabilities`、`marketing_support` |
| 降低项目返工 | CAD/3D、方案设计、安装图纸 | `case_studies`、`customization_services` |
| 降低交付风险 | 产能、质检、认证、售后 | `capacity`、`certifications`、`warranty` |
| 提高信任 | 大牌合作、客户案例、认证、评价 | `partnerships`、`certifications`、`case_studies` |
| 降低采购协调成本 | 一站式产品组合、供应链整合 | `main_products`、`supplier_network`、`case_studies` |

## 4. 输出矩阵

```yaml
job_capability_fit:
  - desired_outcome: ""
    buyer_role: ""
    required_capability: ""
    company_evidence:
      field: ""
      value: ""
      source: ""
    proof_strength: "A | B | C | D"
    fit_level: "strong | medium | weak | unsupported"
    can_be_core_advantage: true
    note: ""
```

## 5. Fit Level 规则

| Fit Level | 条件 |
|---|---|
| strong | 能力直接支撑该 outcome，证据 A/B，且与优先买家强相关 |
| medium | 能力支撑该 outcome，但证据偏弱或需补案例 |
| weak | 能力相关但不直接，容易变成泛化卖点 |
| unsupported | 没有证据，不能进入差异化 |

## 6. 红线

- 没有 `desired_outcome`，不能做能力映射。
- 没有字段来源，不能写进核心优势。
- C/D 级证据不能交给 Differentiation 当主差异化。
- 同一个能力最多服务 2-3 个 Outcome；如果什么都能服务，说明它太泛。

## 7. 源证据锚点

- `agent-ready/Teams/外贸经营定位专家Team/knowledge/roles/03_BuyerJTBD买家任务分析师/03_成功指标DesiredOutcomes构造规则.md`：每个成功指标必须交给 SupplyMapping 匹配企业能力。
- `process/cases/case2_hotblizzard_profile.yaml`：`rd_capabilities`、`customization_services`、`delivery_cycle` 是能力映射字段样例。
- `process/cases/case1_sweethome_extract.md`：R5-R8 是能力与场景化 Job 的映射样例。
