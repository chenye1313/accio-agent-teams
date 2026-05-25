---
name: content-asset-application-router
description: "把企业知识库基座的四库知识进一步路由到品牌品宣、结构化商详、FAQ、询盘跟进、营销推广、社媒和独立站等内容应用场景。"
---

# Content Asset Application Router

## 使用场景

当用户要求：

- 梳理企业内容体系。
- 用 Accio 自动化整理内容知识库。
- 把语音沟通、老板访谈、客户访谈、线下交流变成结构化内容。
- 生成品牌内容、对外品宣、结构化商详、FAQ、询盘跟进、社媒或独立站内容。
- 判断知识库搭好后如何重复调用。
- 把五张主表、询盘事实、报价规则和交易反馈转成内容应用包。

必须使用本 Skill。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/08_内容资产生产线与应用路由.md`
- `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md`
- `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md`
- `output/08_内容体系知识库与Accio自动化梳理蓝图.md`
- `output/11_Accio现场演示与aCIO闭环实现方案.md`

## 输入

```yaml
source_assets:
  - type: "document/voice/chat/interview/backend"
    path_or_description:
business_goal:
master_tables:
  Product_Master:
  Customer_Inquiry_Fact:
  Quote_Rule:
  Delivery_Rule:
  Compliance_Cert_Table:
content_targets:
  - "alibaba_knowledge_base"
  - "structured_product_detail"
  - "faq_pack"
  - "inquiry_followup"
  - "brand_promotion"
  - "marketing_content"
  - "social_independent_site"
privacy_requirement:
```

## 流程

1. 先判断资料是否只够做四库，还是已经能做内容应用包。
2. 对每类资料打 `source_format`：文档、语音转写、线下访谈、聊天记录、后台数据。
3. 识别能形成哪类内容资产：企业实力、品牌品宣、产品表达、买家问题、信任证据、场景方案、交易反馈。
4. 要求构建师补齐 `question / answer / application_scenarios`。
5. 给每条内容资产写 `content_application_route`。
6. 质检公开边界：公开、内部、待验证。
7. 若有五张主表，必须把产品事实、报价边界、证书、交期和交易反馈写入内容应用依据。
8. 输出可交给客户理解的应用路线图。

## 输出

```yaml
content_asset_router_output:
  status: "ready/pass_with_gap/blocked"
  source_summary:
  content_asset_layers:
    enterprise_strength: []
    brand_promotion: []
    product_expression: []
    buyer_qa: []
    trust_evidence: []
    scenario_solution: []
    transaction_feedback: []
  application_routes:
    alibaba_knowledge_base: []
    structured_product_detail: []
    faq_pack: []
    inquiry_followup: []
    brand_promotion: []
    marketing_content: []
    social_independent_site: []
  master_table_usage:
    Product_Master: []
    Customer_Inquiry_Fact: []
    Quote_Rule: []
    Delivery_Rule: []
    Compliance_Cert_Table: []
  missing_inputs:
  public_or_internal_boundary:
  next_actions:
```

## 质量门

必须 `blocked`：

- 没有来源。
- 没有隐私边界。
- 语音资料只有转写，没有结构化抽取。
- FAQ 没有具体问题、答案、应用场景。
- 品宣内容没有证据支撑。
- 客户案例没有公开权限却要对外发布。

允许 `pass_with_gap`：

- 可先生成内部草稿，但缺证书、交易数据或公开授权。
- 可以生成商详 Brief，但缺图片或 SKU 参数。
- 可以生成 FAQ 初稿，但答案需要销售确认。

## 边界

不要承诺：

- 已自动接入阿里后台。
- 已自动同步到国际站。
- 未经客户确认的成交数据可以对外公开。

可以输出：

- 内容资产结构。
- 应用路由表。
- 资料缺口。
- 讲课口径。
- 下一轮访谈问题清单。
