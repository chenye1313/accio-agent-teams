---
name: enterprise-product-asset-extractor
description: "从公司资料、官网、PPT、证书、产品目录、SKU表、报价单和详情页中抽取企业信息库与产品信息库候选条目。"
---

# Enterprise Product Asset Extractor

## 使用场景

当资料路由到企业信息库或产品信息库，需要生成结构化候选条目时使用。

本 Skill 只生成候选条目，不判定最终证据等级。

## 必读知识

先读取：

- `knowledge/roles/02_知识资产构建师/02_资料拆分覆盖清单.md`
- `knowledge/roles/02_知识资产构建师/04_企业与产品信息抽取规则.md`
- `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md`
- `前段ACCIO资料库分类整理/3、正文知识单元化.md`

## 输入

```yaml
source_index:
term_entity_map:
enterprise_product_materials:
library_routing_suggestion:
```

## 流程

1. 从公司资料中抽取 `enterprise_info_candidate`。
2. 从产品资料中抽取 `product_info_candidate`。
3. 区分事实、优势、参数、卖点、场景和证据。
4. 为每个字段保留 `source_id`。
5. 标记缺失字段和推断字段。

## 输出

```yaml
enterprise_product_extraction_output:
  enterprise_info_candidates: []
  product_info_candidates: []
  missing_fields: []
  inference_log: []
```

## 质量门

必须退回或标缺口：

- 企业优势无证据。
- 产品卖点无场景。
- MOQ、交期、参数无来源。
- 产品适合所有买家的泛化表达。

## 边界

不要生成对外文案。
不要承诺未验证交付能力。
不要把后台数据当第五库。
