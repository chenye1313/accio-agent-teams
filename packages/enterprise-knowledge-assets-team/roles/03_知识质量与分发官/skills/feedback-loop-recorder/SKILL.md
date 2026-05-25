---
name: feedback-loop-recorder
description: "记录六组使用企业知识库基座知识后的新问题、新案例、新证据和使用效果，并生成知识库更新请求。"
---

# Feedback Loop Recorder

## 使用场景

当六组使用分发包后，需要把真实业务反馈回流到企业知识库基座时使用。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md`
- `knowledge/roles/03_知识质量与分发官/05_回流记录与知识更新规则.md`
- `knowledge/roles/03_知识质量与分发官/06_输出模板与交接格式.md`

## 输入

```yaml
distribution_package:
group_feedback:
usage_result:
new_materials:
```

## 流程

1. 判断反馈类型：新问题、新案例、新证据、使用结果。
2. 绑定相关 `package_id` 和 `item_id`。
3. 判断是新增、修订、合并、拆分、降级还是归档。
4. 生成 `knowledge_update_request`。
5. 指定返工角色：托管师、构建师或总控。
6. 输出下一轮更新队列。

## 输出

```yaml
feedback_loop_output:
  new_question_candidates: []
  new_case_candidates: []
  new_evidence_records: []
  usage_result_records: []
  knowledge_update_requests: []
```

## 质量门

必须记录：

- 来源组。
- 任务场景。
- 关联知识条目。
- 反馈证据。
- 建议更新动作。

## 边界

不要把单次反馈直接改成正式结论。
不要跳过资料托管和知识构建流程。
不要把未脱敏客户反馈写入公开案例。
