# Sweet Home 数据化升级回放验收

版本：v0.1

用途：验证外贸经营定位专家 Team 是否从“公开资料假设版”升级为“经营数据驱动版”。本文件是人工回放清单，不是真实客户数据。

## Case 信息

| 字段 | 内容 |
|---|---|
| 品牌 | Sweet Home |
| 店铺 | `https://wjsweethome.en.alibaba.com/` |
| 企业 | Hangzhou Weijia Construction And Decoration Co., Ltd. |
| 主营 | Aluminum Pergola + outdoor kitchen + outdoor furniture + aluminum window / doors |
| 已知公开证据 | 1㎡ MOQ、44 页 pergola 产品、SGS / Verified Pro、15 年行业经验 |

## 验收 1：只有公开店铺链接

输入：

```yaml
client_profile:
  website_url: "https://wjsweethome.en.alibaba.com/"
  main_products: ["Aluminum Pergola", "Outdoor Kitchen", "Outdoor Furniture"]
  public_only: true
```

期望：

```yaml
decision_sufficiency_gate:
  data_maturity_grade: "D0"
  output_level: "hypothesis_only"
  forbidden_output:
    - "确定 A 类买家"
    - "确定主推 SKU"
    - "承诺指标提升"
```

客户版必须说明：

```text
目前只有公开店铺信息，以下是第一版方向判断。要做最终经营决策，还需要补后台、询盘和成交数据。
```

## 验收 2：加入店铺后台数据样例

输入补充：

```yaml
store_performance_snapshot:
  period: "last_30_days"
  source_type: "manual_table"
  exposure: 100000
  clicks: 1200
  ctr: "1.2%"
  visitors: 900
  inquiries: 24
  orders: 2
  top_viewed_products: ["Motorized Pergola", "Waterproof Pergola"]
  top_inquiry_products: ["Motorized Pergola"]
  top_searched_keywords: ["motorized pergola", "aluminum pergola"]
  top_buyer_countries: ["US", "AU", "CA"]
```

期望：

```yaml
store_performance_snapshot:
  data_maturity_grade: "D1"
decision_sufficiency_gate:
  output_level: "discussion_ready"
```

必须能判断：

- 流量入口是否足够。
- CTR 是否需要优化。
- 询盘来源产品是否与主推产品一致。
- 但仍不能确定真实买家和成交模式。

## 验收 3：加入询盘 / 成交样例

输入补充：

```yaml
inquiry_buyer_segments:
  period: "last_90_days"
  total_inquiries: 60
  valid_inquiry_rate: "45%"
  segments:
    - buyer_type: "outdoor contractor"
      country: "US"
      main_need: "project-based custom pergola"
      purchase_volume: "20-80 sqm"
      deal_status: "quoted / partial closed"
    - buyer_type: "distributor"
      country: "AU"
      main_need: "bulk standard pergola"
      purchase_volume: "container"
      deal_status: "price sensitive / mostly lost"
```

期望：

```yaml
buyer_jtbd_analysis:
  recommended_priority_buyer: "outdoor contractor"
  buyer_segment_confidence: "discussion_ready"
  mismatch_warning:
    - "distributor inquiries exist but price-sensitive; do not use as primary positioning unless sales data supports it"
```

必须验证：

- BuyerJTBD 会优先用询盘校准买家。
- 没有成交 / 毛利时，不把买家判断写成最终决策。

## 验收 4：加入 SKU 表现样例

输入补充：

```yaml
sku_performance_map:
  period: "last_90_days"
  hero_products: ["Motorized Pergola"]
  inquiry_products: ["Motorized Pergola", "Waterproof Pergola"]
  revenue_products: ["Motorized Pergola"]
  margin_products: ["Custom Bioclimatic Pergola"]
  weak_products: ["Aluminum Doors"]
  mismatch_between_owner_and_market: false
```

期望：

```yaml
business_model_analysis:
  primary_business_model: "柔性定制 / 项目型定制"
  sku_business_implication:
    - "Pergola should remain the hero product"
    - "Outdoor kitchen and furniture are one-order-fit-all supporting products"
```

必须验证：

- BusinessModel 不只看老板想卖什么。
- 主推产品判断能回到 SKU 询盘、成交和毛利。

## 验收 5：客户版报告去黑话

客户版不得出现：

- `M00`
- `M01`
- `JTBD`
- `PASS_WITH_GAP`
- `weak_hypothesis`
- `decision_ready`
- `hypothesis_only`
- `delivery_verdict`

客户版必须回答：

1. 当前经营问题是什么。
2. 真实买家是谁。
3. 主推产品是什么。
4. 页面应该怎么改。
5. 还缺什么资料。
6. 7/30/90 天看什么指标。

## 验收 6：内部版保留工程信息

内部附录必须保留：

- 角色输出摘要。
- 证据等级。
- 决策证据充分性。
- 红线质检。
- 假设披露。
- 返工路由。

## 通过标准

```yaml
sweethome_data_upgrade_replay:
  public_link_only_downgrades_to_hypothesis: true
  store_snapshot_schema_exists: true
  inquiry_segments_can_change_buyer: true
  sku_map_can_change_business_model: true
  customer_version_has_no_internal_jargon: true
  internal_appendix_keeps_evidence_gate: true
  six_customer_questions_answered: true
```

