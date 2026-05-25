---
name: sku-performance-mapper
description: "把 SKU 的曝光、点击、询盘、成交、毛利、复购和国家分布映射成产品经营表现，判断主推产品、辅助产品和需要弱化的产品。"
---

# SKU Performance Mapper

## 使用场景

当用户提供 Top 产品、产品后台、询盘来源产品、成交产品、毛利区间、复购产品或产品运营表时使用。

本 Skill 用于防止生意模式被“老板想卖的产品”带偏，优先看真实市场反馈和利润结构。

## 必读知识

先读取：

- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/01_经营模式分类与判别规则.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/02_证据字段与评分规则.md`
- `knowledge/roles/02_BusinessModel生意模式分析师/03_B2B模式选型决策树.md`

## 输入

可接受：

- Top 浏览产品。
- Top 询盘产品。
- Top 成交产品。
- 产品曝光、点击、询盘、订单。
- 产品毛利区间。
- 产品复购率。
- 产品主要国家。
- 老板想主推的产品。

## 流程

1. 把产品按曝光、点击、询盘、成交、毛利、复购分列。
2. 识别四类 SKU：
   - `hero_products`：值得主推。
   - `inquiry_products`：带来询盘但未必成交。
   - `revenue_products`：带来收入。
   - `margin_products`：利润更好。
3. 判断“想主推产品”和“真实表现产品”是否一致。
4. 识别弱化产品：低询盘、低成交、低毛利、表达分散。
5. 输出产品结构对生意模式的影响。
6. 交接给 BusinessModel 和 Differentiation。

## 输出

必须输出：

```yaml
sku_performance_map:
  period:
  source_type: "backend_export | backend_screenshot | manual_table | interview"
  hero_products:
  inquiry_products:
  revenue_products:
  margin_products:
  repeat_products:
  weak_products:
  owner_preferred_products:
  mismatch_between_owner_and_market:
  product_positioning_recommendation:
  business_model_implication:
  data_gaps:
```

## 质量门

可以支撑 `decision_ready`：

- 有产品维度的询盘、成交、毛利或复购数据。

只能支撑 `discussion_ready`：

- 有 Top 询盘产品，但无成交 / 毛利。

只能支撑 `hypothesis_only`：

- 只有产品目录或店铺上架数量。

## 边界

不要输出：

- 最终定位语。
- 页面文案。
- 买家 JTBD。

可以输出：

- 主推产品建议。
- 辅助产品建议。
- 弱化产品建议。
- 生意模式证据。

