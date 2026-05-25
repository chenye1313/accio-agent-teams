# 05 client_profile.yaml 模板

版本：v0.1

角色：`01_Intake资料采集官`

## 用途

这是 Intake 输出给后续角色的标准数据结构。

后续角色只应该读 `client_profile.yaml` 和必要的证据来源，不应该重新翻客户原始材料。

## 标准模板

```yaml
brand_name: ""
company_name_cn: ""
company_name_en: ""
shop_id: ""
website_url: ""

company_background: ""
establishment_year: ""
company_size: ""
main_markets: []

growth_goal: ""
business_stage: ""
boss_priority: []
non_goals: []

current_business_model: []
main_order_type: []
moq_policy: ""
pricing_logic: ""
profit_constraints: []

main_products: []
supporting_products: []
product_functions: []
product_differentiation: []
customization_services: []
production_process: []
equipment: []
rd_capabilities: []
capacity: ""
delivery_cycle: ""
certifications: []
warranty: ""
after_sales: ""
logistics_options: []

target_buyer_types: []
priority_buyer: ""
buyer_region: []
buyer_stage: []
buyer_pain_points_known: []
buyer_success_metrics_known: []

job_executor: ""
job_decision_maker: ""
job_beneficiary: ""
core_job: ""
struggling_moment: ""
current_workaround: ""
desired_outcomes: []
purchase_anxiety: []
hire_criteria: []
fire_criteria: []

partnerships: []
customer_reviews: []
case_studies: []
factory_photos: []
delivery_proof: []
local_service_assets: []
social_proof: []

current_positioning: ""
current_slogan: ""
preferred_style: ""
color_system: ""
content_assets: []
page_modules_existing: []

target_metrics: []
recent_30_day_issue: ""
recent_90_day_issue: ""

evidence_sources: {}
raw_fields: {}

completeness_grade:
  grade: ""
  reason: []
  missing_required_fields: []
  blocking_fields: []
  can_continue_to_business_model: false
  report_mode: ""

intake_notes:
  assumptions: []
  risks: []
  recommended_next_step: ""
```

## 最小通过样例

```yaml
brand_name: "HOTBLIZZARD"
shop_id: "cnshengfeile"
current_positioning: "brand incubation supply chain partner"
current_slogan: "Start small, Dream big"
main_products:
  - "men's hoodies"
  - "T-shirts"
  - "streetwear accessories"
main_markets:
  - "United States"
  - "United Kingdom"
  - "Australia"
growth_goal: "帮助街头潮牌创业者从小单测试走向稳定量产，并提升高质量询盘与成交效率。"
business_stage: "增长 / 转型"
boss_priority:
  - "订单增长"
  - "品牌孵化"
  - "小单测试"
current_business_model:
  - "品牌孵化供应链"
  - "小单定制"
  - "柔性制造"
main_order_type:
  - "小单测试"
  - "深度定制"
  - "量产补货"
target_buyer_types:
  - "街头潮牌创业者"
  - "跨境服装卖家"
priority_buyer: "正在测试新品的街头潮牌创始人 / 小型潮流服饰品牌主"
product_differentiation:
  - "深度定制、多维度可定制、先测款再放量"
customization_services:
  - "面料"
  - "工艺"
  - "logo定制"
  - "包装袋"
certifications:
  - "Oeko-Tex 100"
  - "16 CFR 1610"
  - "CP65"
delivery_cycle: "7 天打样 + 45 天量产"
partnerships:
  - "美特斯邦威"
  - "New Balance"
buyer_pain_points_known:
  - "设计概念难以稳定转成可售样衣"
  - "小单测款与规模量产之间断层"
buyer_success_metrics_known:
  - "更快完成样衣验证"
  - "降低首批库存风险"
  - "缩短新品上架周期"
evidence_sources:
  brand_name: "案例 2 输入表"
  product_differentiation: "案例 2 输入表"
  delivery_cycle: "案例 2 输入表"
completeness_grade:
  grade: "A"
  reason:
    - "最小 12 字段齐全"
    - "有认证、合作品牌、交付周期等证据资产"
  missing_required_fields: []
  blocking_fields: []
  can_continue_to_business_model: true
  report_mode: "full"
```

## 输出检查

Intake 输出前必须检查：

- `brand_name` 是否存在。
- `main_products` 是否为 list。
- `target_buyer_types` 是否为 list。
- `priority_buyer` 是否明确。
- `product_differentiation` 是否不是空泛词。
- `certifications` 或其他信任资产是否存在。
- `completeness_grade.grade` 是否为 A/B/C/D。
- `evidence_sources` 是否包含关键字段来源。
