---
name: term-entity-normalizer
description: "统一企业知识资产中的公司、产品、SKU、客户、认证、渠道和证据实体，输出 term_entity_map、synonym_map 和 conflict_terms。"
---

# Term Entity Normalizer

## 使用场景

当资料已经完成来源索引和权限处理，需要进入四库构建前使用。

本 Skill 负责术语和实体统一，不负责正式四库抽取。

## 必读知识

先读取：

- `knowledge/roles/02_知识资产构建师/03_术语实体标准化规则.md`
- `前段ACCIO资料库分类整理/1、术语专项提取.md`

## 输入

```yaml
asset_manifest:
source_index:
material_text_or_summary:
library_routing_suggestion:
```

## 流程

1. 识别公司实体、产品实体、客户实体、认证实体、渠道实体、证据实体。
2. 建立原始词和标准词映射。
3. 合并同义词。
4. 标出冲突词和低置信实体。
5. 保留来源 ID。

## 输出

```yaml
term_entity_normalization_output:
  term_entity_map: []
  synonym_map: []
  conflict_terms: []
  low_confidence_terms: []
```

## 质量门

必须标记冲突：

- 同一产品多个名称。
- 同一 SKU 多个型号。
- 同一认证多个简称。
- 客户类型混用。

## 边界

不要创造产品名。
不要删除原始词。
不要把营销口号当术语。
