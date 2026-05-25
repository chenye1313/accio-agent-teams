---
name: six-group-knowledge-dispatcher
description: "把通过质量门的四库知识按经营、选品、内容设计、推流运营、商机转化、私域沉淀六组任务重新打包，并定义使用边界和回流要求。"
---

# Six Group Knowledge Dispatcher

## 使用场景

当四库知识已经通过证据和隐私质量门，需要分发给六组数字化经营团队时使用。

本 Skill 负责知识分发和回流要求，不负责重新抽取四库内容。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md`
- `knowledge/roles/00_Lead知识资产总控/06_输出模板与最终交付格式.md`
- `output/04_外贸AI数字化经营部门蓝图.md`
- `output/05_企业知识资产中心与第0组蓝图.md`

## 输入

```yaml
approved_library_items:
  enterprise_info: []
  product_info: []
  customer_qa: []
  customer_case: []
six_group_usage_needs:
  business_positioning_group:
  product_selection_group:
  content_design_group:
  traffic_operation_group:
  opportunity_conversion_group:
  private_domain_group:
evidence_gaps:
```

## 流程

1. 识别每条知识最适合服务哪一组。
2. 按任务打包，而不是按资料来源打包。
3. 为每个分发包写 `allowed_usage` 和 `forbidden_usage`。
4. 标明证据缺口和待验证内容。
5. 为每组定义回流要求。
6. 输出六组分发计划。

## 输出

```yaml
six_group_distribution_plan:
  business_positioning_group:
    package_name: "企业优势包 / 客户问题包 / 案例证据包 / 经营缺口包"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
  product_selection_group:
    package_name: "产品线包 / SKU 表 / 客户需求包 / 产品反馈包"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
  content_design_group:
    package_name: "企业故事包 / 产品卖点包 / 案例信任包 / FAQ 内容包"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
  traffic_operation_group:
    package_name: "产品标签包 / 关键词线索包 / 客户问题包 / 案例场景包"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
  opportunity_conversion_group:
    package_name: "异议处理包 / 报价问答包 / 案例证明包 / 产品交付包"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
  private_domain_group:
    package_name: "客户标签包 / 复购线索包 / 客户反馈包 / 新案例回收表"
    knowledge_items: []
    allowed_usage: []
    forbidden_usage: []
    feedback_required: []
```

## 质量门

必须失败：

- 分发包没有目标组。
- 分发包没有使用场景。
- 分发包没有回流要求。
- 未通过质量门的知识被分发。
- 内部资料被用于对外内容。

## 边界

不要替六组生成最终业务交付。
不要修改四库原始条目。
不要省略证据缺口。
