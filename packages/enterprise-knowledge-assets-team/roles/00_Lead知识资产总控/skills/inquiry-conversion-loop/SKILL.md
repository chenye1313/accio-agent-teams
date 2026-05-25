---
name: inquiry-conversion-loop
description: "用企业知识库基座、五张主表和内容应用路由处理新询盘，输出询盘评分、英文首响、报价前确认、跟进计划和回流记录。"
---

# Inquiry Conversion Loop

## 使用场景

当用户要演示或实际处理阿里国际站询盘、RFQ、客户私信、样品申请时使用。

本 Skill 只生成建议、草稿和回流项。报价、折扣、承诺交期、发送消息必须人工确认。

## 输入

```yaml
new_inquiry:
  source: "Alibaba Inquiry/RFQ/IM/email/demo"
  buyer_country:
  product_id:
  requested_qty:
  customization:
  required_certificates:
  conversation_text:
knowledge_context:
  enterprise_info:
  product_info:
  customer_qa:
  customer_case:
master_tables:
  Product_Master:
  Customer_Inquiry_Fact:
  Quote_Rule:
  Delivery_Rule:
  Compliance_Cert_Table:
```

## 流程

1. 提取买家问题、采购阶段、数量、定制、证书、价格、交期要求。
2. 从 `Product_Master` 找产品事实。
3. 从 `Quote_Rule` 找报价边界、样品政策和审批阈值。
4. 从 `Compliance_Cert_Table` 找证书和禁用表达。
5. 从客户问答库找标准回答和应用场景。
6. 从客户案例库找可匿名引用的案例证据。
7. 输出评分、首响草稿、报价前人工确认清单、跟进计划。
8. 输出回流项：新问题、新异议、新案例线索、新规则缺口。

## 输出

```yaml
inquiry_conversion_output:
  status: "ready/pass_with_gap/blocked"
  inquiry_score:
    score:
    priority: "high/medium/low"
    reasons: []
  context_used:
    product_facts: []
    quote_rules: []
    certificates: []
    qa_items: []
    case_evidence: []
  first_reply_draft:
    language: "English"
    message: ""
  human_approval_checklist:
    - item:
      reason:
  followup_plan:
    day_7:
    day_14:
    day_30:
  feedback_loop:
    new_qa: []
    new_case_signal: []
    master_table_updates: []
    missing_knowledge: []
```

## 红线

必须标人工确认：

- 低于底价或超出最大折扣。
- 涉及证书、法规、医疗、性能、质保等确定性承诺。
- 涉及客户真实姓名、成交价、合同、联系方式。
- 交期没有来自主表或人工确认。

