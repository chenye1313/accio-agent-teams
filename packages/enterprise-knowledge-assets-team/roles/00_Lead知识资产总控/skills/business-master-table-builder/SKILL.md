---
name: business-master-table-builder
description: "把企业资料、产品目录、询盘、报价规则、交付和合规资料整理成 aCIO 首批五张主表，供 Skills 和业务 Agent 调用。"
---

# Business Master Table Builder

## 使用场景

当用户要把企业资料变成可执行经营事实源时使用。

本 Skill 生成五张主表草稿，不替代正式 ERP/CRM 数据治理。无来源字段必须标 `needs_validation`。

## 输入来源

```yaml
source_assets:
  company_profile:
  product_catalog:
  inquiry_transcripts:
  quote_rules:
  delivery_records:
  certificate_files:
  transaction_snapshot:
```

## 五张主表

### Product_Master

```yaml
product_id:
product_line:
sku:
target_market:
core_keywords:
features:
use_cases:
MOQ:
price_floor:
lead_time_days:
certificates:
customization:
proof:
banned_claims:
source_id:
status: "usable/needs_validation/internal_only"
```

### Customer_Inquiry_Fact

```yaml
inquiry_id:
customer_id:
source:
country:
asked_product:
asked_qty:
customization:
intent_score:
objection:
next_action:
owner:
due_date:
source_id:
status:
```

### Quote_Rule

```yaml
market:
product_id:
incoterm:
target_margin:
sample_policy:
max_discount:
approval_threshold:
preferred_payment:
logistics_note:
source_id:
status:
```

### Delivery_Rule

```yaml
product_id:
sample_lead_time:
mass_production_lead_time:
packing_requirement:
logistics_risk:
customer_notice_template:
source_id:
status:
```

### Compliance_Cert_Table

```yaml
product_id:
market:
required_certificates:
available_documents:
restricted_claims:
expiry_or_review_date:
source_id:
status:
```

## 流程

1. 先列 `source_inventory`。
2. 逐张表抽字段，不确定的写 `needs_validation`。
3. 对同一产品、客户、证书做实体标准化。
4. 把每张表和四库关联起来。
5. 输出缺口：缺价格、缺证书、缺交期、缺案例、缺公开权限。

## 输出

```yaml
master_table_builder_output:
  status: "ready/pass_with_gap/blocked"
  source_inventory: []
  tables:
    Product_Master: []
    Customer_Inquiry_Fact: []
    Quote_Rule: []
    Delivery_Rule: []
    Compliance_Cert_Table: []
  links_to_libraries:
    enterprise_info: []
    product_info: []
    customer_qa: []
    customer_case: []
  missing_fields: []
  validation_notes: []
```

