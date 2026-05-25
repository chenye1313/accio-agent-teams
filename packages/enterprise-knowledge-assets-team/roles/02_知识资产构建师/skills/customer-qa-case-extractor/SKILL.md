---
name: customer-qa-case-extractor
description: "从询盘、聊天、邮件、录音、访谈、销售复盘、成交和交付反馈中抽取客户问答库与客户案例库候选条目。"
---

# Customer QA Case Extractor

## 使用场景

当资料路由到客户问答库或客户案例库，需要抽取问答、异议、应用场景、标签、关键词、案例线索和可复用方法时使用。

本 Skill 只生成候选条目，不决定最终公开权限。

## 必读知识

先读取：

- `knowledge/roles/02_知识资产构建师/02_资料拆分覆盖清单.md`
- `knowledge/roles/02_知识资产构建师/05_客户问答与案例抽取规则.md`
- `前段ACCIO资料库分类整理/2、案例专项提取.md`
- `前段ACCIO资料库分类整理/4、FAQ 生成与整合.md`

## 输入

```yaml
source_index:
term_entity_map:
customer_materials:
permission_tags:
```

## 流程

1. 抽取客户原始问题。
2. 归一问题并保留原文。
3. 标注买家语境和异议类型。
4. 将答案拆成核心观点、事实依据、案例、行动步骤、边界和可复用公式。
5. 抽取应用场景、标签和问题关键词。
6. 抽取案例背景、问题、过程、方案、结果。
7. 标注可复用方法和公开权限候选。
8. 输出缺失字段和推断记录。

## 输出

```yaml
customer_qa_case_extraction_output:
  customer_qa_candidates: []
  customer_case_candidates: []
  missing_fields: []
  inference_log: []
```

## 质量门

必须降级：

- 问答没有买家语境。
- 问答没有具体问题。
- 问答没有应用场景。
- 问答缺少标签或问题关键词。
- 案例没有结果。
- 只有老板回忆，没有证据。
- 权限未知但想对外使用。

## 边界

不要编造成交结果。
不要公开客户敏感信息。
不要把单次经验写成普遍规律。
