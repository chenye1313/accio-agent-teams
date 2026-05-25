---
name: knowledge-ai-slop-scanner
description: "扫描四库候选条目中的泛泛表达、无证据优势、模板化问答、缺应用场景问答、空壳案例和经验冒充事实问题。"
---

# Knowledge AI Slop Scanner

## 使用场景

当候选条目已通过基础来源检查，但需要判断它是不是可用知识，而不是漂亮废话时使用。

## 必读知识

先读取：

- `knowledge/roles/03_知识质量与分发官/03_四库条目验收与AI-Slop扫描.md`
- `knowledge/roles/03_知识质量与分发官/02_证据等级与来源一致性规则.md`
- `knowledge/roles/02_知识资产构建师/02_资料拆分覆盖清单.md`

## 输入

```yaml
review_items:
target_library:
source_evidence:
quality_scores:
```

## 流程

1. 按四库字段检查完整度。
2. 找出换成任何企业都成立的表达。
3. 找出没有买家语境的产品卖点和问答。
4. 找出没有应用场景、标签、关键词的问答。
5. 找出没有问题、方案、结果的案例。
6. 找出口述经验冒充事实的内容。
7. 给出删除、降级、返工或带边界通过的建议。

## 输出

```yaml
ai_slop_scan_output:
  clean_items: []
  slop_findings:
    - item_id: ""
      slop_type: "generic_claim | unsupported_advantage | hollow_case | contextless_feature | template_answer | missing_qa_scenario | missing_tags_keywords | experience_as_fact"
      reason: ""
      required_fix: ""
  downgrade_recommendations: []
  rework_requests: []
```

## 质量门

下列内容不能直接进入正式库：

- 无来源优势判断。
- 无客户背景案例。
- 无使用场景产品卖点。
- 无异议类型问答。
- 无应用场景、标签或问题关键词的问答。
- 只有形容词没有事实。

## 边界

不要把所有不完整内容都删掉；有业务价值但证据不足的内容应进入 `needs_validation`。
