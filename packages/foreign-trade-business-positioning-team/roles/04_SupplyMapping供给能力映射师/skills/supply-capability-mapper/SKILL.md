---
name: supply-capability-mapper
description: "把 BuyerJTBD 的核心 Job 和 Desired Outcomes 映射到外贸企业真实能力证据，输出能力证据等级、无证据优势、能力缺口和交给差异化定位的强能力清单。"
---

# Supply Capability Mapper

## 使用场景

当已经有 `buyer_jtbd_analysis`，需要判断企业能力是否支撑买家 Job、哪些优势可进入差异化、哪些说法必须禁用时使用。

本 Skill 只负责能力证据映射，不负责写最终定位语、Slogan、页面表达或 Lead 质检。

## 必读知识

先读取：

- `knowledge/roles/04_SupplyMapping供给能力映射师/01_能力证据分级规则.md`
- `knowledge/roles/04_SupplyMapping供给能力映射师/02_Job到能力映射表.md`
- `knowledge/roles/04_SupplyMapping供给能力映射师/03_证据缺口与补问规则.md`
- `knowledge/roles/04_SupplyMapping供给能力映射师/05_输出模板与交接格式.md`
- `knowledge/shared/07_经营数据证据门.md`

按需读取：

- `knowledge/roles/04_SupplyMapping供给能力映射师/04_案例能力校准.md`

## 输入

必须有：

```yaml
buyer_jtbd_analysis:
  core_job:
  desired_outcomes:
  purchase_anxiety:
  hire_criteria:
  fire_criteria:
  handoff_to_supply_mapping:

client_profile_yaml:
  product_differentiation:
  customization_services:
  rd_capabilities:
  delivery_cycle:
  certifications:
  partnerships:
  case_studies:
  capacity:

market_competitor_scan:
```

## 流程

1. 读取每个 Desired Outcome。
2. 判断该 Outcome 需要的能力。
3. 从企业字段中寻找证据。
4. 调用或读取 `market-competitor-scanner`，识别竞品通用说法和错位机会。
5. 给证据打 A/B/C/D 等级。
6. 判定 fit_level：`strong | medium | weak | unsupported`。
7. 把无证据优势写入 `unsupported_claims`。
8. 生成给 Differentiation 的强能力、证据资产、禁用话术和风险。

## 输出

必须输出：

```yaml
supply_mapping_analysis:
  role_id: "04_SupplyMapping供给能力映射师"
  status: "pass" # pass | need_more_info | blocked
  job_capability_fit:
    - desired_outcome:
      buyer_role:
      required_capability:
      company_evidence:
        field:
        value:
        source:
      proof_strength: "A | B | C | D"
      fit_level: "strong | medium | weak | unsupported"
      can_be_core_advantage:
      note:
  capability_evidence_table:
  market_common_claims:
  differentiation_openings:
  competitor_reference_limits:
  unsupported_claims:
    - claim:
      why_unsupported:
      needed_evidence:
      follow_up_question:
  capability_gaps:
  handoff_to_differentiation:
    strongest_capabilities:
    usable_proof_assets:
    forbidden_claims:
    differentiation_risk:
```

## 质量门

必须阻断：

- 没有 `desired_outcomes`。
- 核心 Job 没有任何能力支撑。
- 所有候选核心能力都是 C/D 级证据。
- 没有来源字段。

必须降级为 `need_more_info`：

- 有能力但无案例。
- 有交期但无数字。
- 有合作品牌但合作内容不清。
- 有认证但适用市场不清。
- 只有竞品公开资料，没有我方能力证据。

## 边界

不要输出：

- 最终经营定位。
- 差异化口号。
- Slogan。
- 阿里国际站 7 屏 brief。
- Lead 最终质量门。
