# 03 四库条目验收与 AI-Slop 扫描

版本：v0.1  
适用角色：`03_知识质量与分发官`

## 1. 企业信息库验收

最小字段：

```yaml
enterprise_info_item:
  item_id: ""
  company_profile: ""
  capabilities: []
  certifications: []
  service_scope: []
  advantages: []
  evidence: []
  source_id: []
  evidence_level: ""
  permission_status: ""
```

必须检查：

- 企业优势是否有证据。
- 工厂能力、服务能力、认证是否能回到资料。
- “多年经验”“服务全球客户”等表达是否有具体事实支撑。

## 2. 产品信息库验收

最小字段：

```yaml
product_info_item:
  item_id: ""
  product_line: ""
  sku: ""
  features: []
  use_cases: []
  customization: []
  delivery: ""
  proof: []
  source_id: []
  evidence_level: ""
  permission_status: ""
```

必须检查：

- 卖点是否对应买家场景。
- 参数、交期、定制能力是否来自可靠来源。
- 未验证的产品承诺是否被降级。

## 3. 客户问答库验收

最小字段：

```yaml
customer_qa_item:
  item_id: ""
  question: ""
  buyer_context: ""
  answer: ""
  answer_structure:
    core_point: ""
    facts: []
    cases: []
    action_steps: []
    limits: []
    reusable_formula: ""
  application_scenarios: []
  objection_type: ""
  tags: []
  question_keywords: []
  source: []
  recommended_usage: []
  evidence_level: ""
  permission_status: ""
```

必须检查：

- 问题是否来自真实客户或明确访谈场景。
- 回答是否能解决异议，而不是泛泛介绍。
- 答案是否至少有 `core_point`，复杂答案是否拆出事实、案例、步骤、边界或可复用公式。
- 是否有明确 `application_scenarios`，能说明这个问答在哪个经营动作中落地。
- 是否有 `tags` 和 `question_keywords`，能支持检索、内容选题、推流和六组分发。
- 是否标注报价、交期、售后、认证、定制、风险等异议类型。

## 4. 客户案例库验收

最小字段：

```yaml
customer_case_item:
  item_id: ""
  buyer_type: ""
  problem: ""
  conversation_summary: ""
  solution: ""
  result: ""
  reusable_method: ""
  evidence_level: ""
  permission_status: ""
  can_publicize: "yes | anonymized | internal_only | no | unknown"
```

必须检查：

- 客户是谁：至少有国家、行业、买家类型或采购场景。
- 遇到什么问题。
- 我们怎么沟通或解决。
- 结果如何。
- 能否公开。

## 5. AI-Slop 扫描

以下内容必须标记：

| 类型 | 表现 | 处理 |
|---|---|---|
| 泛泛优势 | 换成任何公司都成立 | 要求补证据或删除 |
| 无来源结论 | “我们最专业”“转化更高”无来源 | 降为 D 或待验证 |
| 案例空壳 | 只有客户夸奖，没有问题、方案、结果 | 退回补案例结构 |
| 卖点悬空 | 只有功能，没有使用场景 | 退回补买家场景 |
| 问答模板化 | 回答像客服套话，未回应异议 | 退回重写 |
| 问答不可调用 | 有问题和答案，但没有应用场景、标签或关键词 | 退回补应用结构 |
| 经验冒充事实 | 老板口述被写成确定市场规律 | 降为 C 并标注待验证 |

## 6. 20 分制验收

```yaml
quality_score:
  accuracy: 0
  completeness: 0
  traceability: 0
  usability: 0
  total: 0
  pass_line: 16
```

判定：

| 总分 | 判定 | 处理 |
|---:|---|---|
| 18-20 | `approve` | 可进入正式库 |
| 16-17 | `approve_with_boundary` | 可用，但必须附限制 |
| 12-15 | `needs_validation` | 进入待验证清单 |
| 0-11 | `reject_or_rework` | 拒绝或返工 |

## 7. 输出

```yaml
library_item_review:
  approved_items: []
  approved_with_boundary_items: []
  needs_validation_items: []
  internal_only_items: []
  rejected_items: []
  ai_slop_findings: []
  rework_requests: []
```
