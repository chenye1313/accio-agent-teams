---
name: store-performance-intake
description: "接入阿里国际站后台截图、Excel 或手工表，把曝光、点击、访客、询盘、订单、关键词、产品和国家数据归一成 store_performance_snapshot.yaml，并判断数据成熟度。"
---

# Store Performance Intake

## 使用场景

当用户提供阿里后台截图、运营简表、Excel 导出、广告数据、店铺表现截图或手工统计表时使用。

本 Skill 只负责经营数据接入和归一，不负责下经营定位结论。经营结论交给 BusinessModel、BuyerJTBD、Differentiation 和 Lead。

## 必读知识

先读取：

- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/shared/05_经营罗盘指标映射.md`
- `knowledge/roles/01_Intake资料采集官/01_字段归一规则.md`
- `knowledge/roles/01_Intake资料采集官/02_完整度评分与阻断规则.md`

## 输入

可接受：

- 阿里后台截图。
- 后台 Excel / CSV 导出。
- 手工经营表。
- 广告数据截图。
- Top 产品、Top 关键词、国家分布截图。
- 业务员整理的询盘 / 订单汇总。

## 流程

1. 识别数据来源：后台导出、后台截图、手工表、客户口述或 Agent 推断。
2. 识别统计周期：近 7 天、近 30 天、近 90 天或自定义。
3. 归一店铺漏斗字段：曝光、点击、CTR、访客、PV、询盘、订单。
4. 归一产品字段：Top 浏览产品、Top 询盘产品、Top 成交产品。
5. 归一市场字段：Top 国家、关键词、广告花费、平均点击成本。
6. 识别业务响应字段：首响时间、报价转化、跟进状态。
7. 给出 `data_maturity_grade` 和 `data_gaps`。
8. 输出最多 7 个下一步补数问题。

## 输出

必须输出：

```yaml
store_performance_snapshot:
  period:
  source_type: "backend_export | backend_screenshot | manual_table | interview | inferred"
  exposure:
  clicks:
  ctr:
  visitors:
  page_views:
  inquiries:
  orders:
  conversion_rate:
  top_viewed_products:
  top_inquiry_products:
  top_order_products:
  top_searched_keywords:
  top_buyer_countries:
  ad_spend:
  avg_click_cost:
  response_time:
  quote_rate:
  data_maturity_grade: "D0 | D1 | D2 | D3 | D4"
  data_gaps:
  next_data_request:
```

## 质量门

可以进入 BP_M00.5：

- 至少有店铺链接和基础企业资料。
- 或者有任意一类后台指标截图。

必须标注 `hypothesis_only`：

- 只有公开店铺信息。
- 只有客户口述，没有后台或截图。

必须提醒客户补数：

- 没有统计周期。
- 只有流量，没有询盘 / 订单。
- 只有总数，没有产品、国家或关键词拆分。

## 边界

不要输出：

- 最终经营定位。
- 生意模式判断。
- 买家 JTBD。
- 差异化话术。
- 页面 7 屏 brief。

这些交给后续角色。

