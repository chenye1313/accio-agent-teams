# Agents：SupplyMapping 内部调度

SupplyMapping 对外是一个 Agent，对内按 6 个子模块执行。

## S01 Outcome Capability Resolver

职责：

- 读取 BuyerJTBD 的 `desired_outcomes`。
- 判断每个 Desired Outcome 需要什么企业能力。
- 把 Outcome 转成 `required_capability`。

输出：

- `outcome_capability_map`
- `required_capability_candidates`

## S02 Evidence Extractor

职责：

- 从 `client_profile.yaml`、Intake 字段和案例资料中抽取企业能力证据。
- 识别证据字段、证据值和来源。

输入字段：

- `product_differentiation`
- `customization_services`
- `rd_capabilities`
- `delivery_cycle`
- `certifications`
- `partnerships`
- `case_studies`
- `capacity`
- `after_sales`
- `warranty`

输出：

- `capability_evidence_table`
- `source_field_map`

## S03 Proof Strength Grader

职责：

- 按 `01_能力证据分级规则.md` 判定 A/B/C/D。
- 判断每条证据是否可作为核心优势。
- 过滤同行通用卖点。

输出：

- `proof_strength`
- `fit_level`
- `can_be_core_advantage`

## S03.5 Market Competitor Scanner

职责：

- 读取 `market_competitor_scan` 或调用 `market-competitor-scanner`。
- 区分行业通用话术和我方可错位优势。
- 标注公开抓取结论只能作 C 级市场参照。

输出：

- `market_common_claims`
- `differentiation_openings`
- `competitor_reference_limits`

## S04 Unsupported Claim Filter

职责：

- 识别无证据优势、同行通用口号和过度承诺。
- 写入 `unsupported_claims`。
- 生成补问和所需证据。

输出：

- `unsupported_claims`
- `capability_gaps`
- `follow_up_questions`

## S05 Differentiation Handoff Builder

职责：

- 生成 `supply_mapping_analysis`。
- 给 Differentiation 交接强能力、可用证据、禁用话术和定位风险。

输出：

- `handoff_to_differentiation`

## 调用顺序

```text
S01 Outcome Capability Resolver
  -> S02 Evidence Extractor
  -> S03 Proof Strength Grader
  -> S03.5 Market Competitor Scanner
  -> S04 Unsupported Claim Filter
  -> S05 Differentiation Handoff Builder
```

## 状态规则

```yaml
status:
  pass: "至少 2 条强/中等能力能支撑核心 Job，进入 Differentiation"
  need_more_info: "有候选能力但证据不足，退回 Intake 补证据"
  blocked: "核心 Job 没有任何能力支撑，禁止进入差异化"
```

## 内置自检

```yaml
supply_mapping_self_check:
  every_outcome_has_required_capability: true
  every_core_capability_has_source: true
  competitor_reference_not_used_as_sales_evidence: true
  no_d_level_core_advantage: true
  unsupported_claims_extracted: true
  handoff_to_differentiation_ready: true
```
