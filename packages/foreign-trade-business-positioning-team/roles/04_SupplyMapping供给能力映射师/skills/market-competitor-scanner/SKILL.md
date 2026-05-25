---
name: market-competitor-scanner
description: "抓取或整理阿里搜索结果、竞品店铺、竞品详情页、价格、MOQ、认证和页面信任资产，输出市场通用说法和错位机会。"
---

# Market Competitor Scanner

## 使用场景

当用户提供关键词、竞品链接、阿里搜索结果截图、RFQ 样本、行业页面或希望判断卖点是否稀缺时使用。

本 Skill 只做市场参照，不替代客户自有后台、询盘和成交证据。

## 必读知识

先读取：

- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/roles/04_SupplyMapping供给能力映射师/01_能力证据分级规则.md`
- `knowledge/roles/04_SupplyMapping供给能力映射师/03_证据缺口与补问规则.md`
- `knowledge/roles/05_Differentiation差异化定位师/05_禁用话术与竞争对比.md`

## 输入

可接受：

- 核心关键词。
- 阿里搜索结果页截图或摘要。
- 竞品店铺链接。
- 竞品产品详情页。
- 竞品价格、MOQ、交期、认证、页面模块。
- RFQ / 买家采购需求样本。
- Google 或行业搜索摘要。

## 流程

1. 按关键词整理搜索结果。
2. 抽取竞品：定位说法、主推产品、价格带、MOQ、信任资产、交付承诺。
3. 标记行业通用话术：如 high quality、OEM/ODM、factory direct、customizable。
4. 对比我方已有证据：哪些是真的稀缺，哪些只是行业标配。
5. 输出错位机会：价格、MOQ、服务对象、场景、证据资产、页面结构。
6. 明确所有公开抓取结论的证据等级为 C，不能替代成交证据。

## 输出

必须输出：

```yaml
market_competitor_scan:
  keywords:
  source_type: "public_search | screenshots | manual_competitor_list"
  competitors:
    - name:
      url:
      positioning:
      main_products:
      price_band:
      moq:
      trust_assets:
      page_claims:
      delivery_claims:
  market_common_claims:
  differentiation_openings:
  evidence_level: "C_public_reference"
  cannot_replace:
    - store_backend_data
    - inquiry_data
    - sales_data
  handoff_to_supply_mapping:
```

## 质量门

可以作为差异化参照：

- 至少有 3 个竞品或 1 个关键词下 Top 搜索结果。

不能作为确定经营结论：

- 只有公开竞品，没有自有询盘 / 成交 / 后台。

必须降级：

- 来源不明的第三方数据。
- 无法核验的市场规模数字。
- 竞品页面上没有出现的宣传话术。

## 边界

不要输出：

- 我方主模式最终结论。
- 目标买家最终结论。
- 指标提升承诺。

可以输出：

- 市场参照。
- 竞品通用说法。
- 错位表达机会。
- 需要我方补证据的能力点。

