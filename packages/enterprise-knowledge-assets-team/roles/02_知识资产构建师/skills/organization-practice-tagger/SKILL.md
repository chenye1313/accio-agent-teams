---
name: organization-practice-tagger
description: "从案例、问答、访谈和复盘中沉淀组织实践标签，将方法经验内沉到 reusable_method、recommended_usage 和 practice tags。"
---

# Organization Practice Tagger

## 使用场景

当客户案例、问答、老板经验、销售复盘中出现可复用方法或判断标准时使用。

本 Skill 负责内部方法沉淀，不创建对外第五库。

## 必读知识

先读取：

- `knowledge/roles/02_知识资产构建师/06_组织实践标签与方法内沉规则.md`
- `前段ACCIO资料库分类整理/优秀商业访谈师特质.md`

## 输入

```yaml
customer_qa_candidates:
customer_case_candidates:
interview_notes:
sales_review:
source_index:
```

## 流程

1. 识别场景、流程、角色、判断、动作、标准、机制、反馈。
2. 判断方法经验应内沉到案例、问答还是组织实践标签。
3. 标记 `verified | needs_validation | internal_only`。
4. 保留来源 ID。
5. 输出组织实践标签和方法内沉建议。

## 输出

```yaml
organization_practice_output:
  organization_practice_tags: []
  reusable_method_candidates: []
  recommended_usage_updates: []
  needs_validation_methods: []
```

## 质量门

必须标记 `needs_validation`：

- 只有口述，没有案例。
- 只有一次销售经验。
- 没有明确客户场景。

必须标记 `internal_only`：

- 涉及内部报价策略。
- 涉及客户隐私。
- 涉及不适合对外公开的谈判过程。

## 边界

不要创建第五库。
不要输出课程方法论包装。
不要把内部经验直接写成公开内容。
