---
name: expression-landing-brief-builder
description: "把通过的经营定位和差异化点转成阿里国际站首屏、7 屏 brief、信任资产展示、视觉锤和 CTA，降低识别、理解、信任、决策与行动成本。"
---

# Expression Landing Brief Builder

## 使用场景

当已经有 `differentiation_analysis`，需要生成阿里国际站页面 brief、语言钉子、视觉锤、信任资产展示和 CTA 时使用。

本 Skill 只负责表达落地，不负责重新定位、能力证明或最终质量门。

## 必读知识

先读取：

- `knowledge/roles/06_Expression表达落地师/01_表达输入门槛与五成本模型.md`
- `knowledge/roles/06_Expression表达落地师/02_阿里国际站7屏Brief模板.md`
- `knowledge/roles/06_Expression表达落地师/03_信任资产与证据展示规则.md`
- `knowledge/roles/06_Expression表达落地师/04_语言钉子视觉锤CTA规则.md`
- `knowledge/roles/06_Expression表达落地师/06_输出模板与交接格式.md`
- `knowledge/shared/06_客户版表达与去黑话规则.md`

按需读取：

- `knowledge/roles/06_Expression表达落地师/05_案例表达校准.md`

## 输入

必须有：

```yaml
differentiation_analysis:
  positioning_statement:
  differentiation_points:
  forbidden_claims:
  expression_path:
  handoff_to_expression:
    positioning_statement:
    differentiation_points:
    proof_assets:
    forbidden_claims:
```

## 流程

1. 检查定位和证据资产是否可用。
2. 生成语言钉子。
3. 做客户版可读性检查：10 秒能否看懂、是否有内部黑话、是否有语义别扭。
4. 设计视觉锤方向和所需素材。
5. 生成 7 屏 brief。
6. 标注信任资产来源和授权状态。
7. 生成 CTA。
8. 给 MetricQualityGate 交接表达动作和预期指标影响。

## 输出

必须输出：

```yaml
expression_brief:
  role_id: "06_Expression表达落地师"
  status: "pass" # pass | need_more_info | blocked
  slogan_options:
    - text:
      usage:
      reason:
  visual_hammer:
    concept:
    assets_needed:
    risk:
  trust_proofs:
    - proof:
      source_field:
      display_mode:
      authorization_status:
  seven_screen_brief:
    - screen:
      name:
      objective:
      target_buyer_decision:
      headline:
      subcopy:
      proof_assets:
      visual_direction:
      cta:
      cost_reduced:
  cta:
    primary:
    secondary:
    required_buyer_input:
  readability_check:
  content_asset_gaps:
  handoff_to_metric_quality_gate:
```

## 质量门

必须阻断：

- 无 `positioning_statement`。
- 无 `proof_assets`。
- 无法生成 7 屏。
- CTA 只有 `Contact us`。
- 首屏文案客户 10 秒内无法理解。
- 出现内部黑话或语义不通的英文表达。

必须降级为 `need_more_info`：

- 合作品牌授权未知。
- 缺案例图片或过程图。
- 信任资产可写但不可公开展示。
- 缺产品结构素材。

## 边界

不要输出：

- 新定位。
- 最终报告。
- 经营罗盘质检。
- 无授权 Logo 展示建议。
- 空泛视觉风格。
