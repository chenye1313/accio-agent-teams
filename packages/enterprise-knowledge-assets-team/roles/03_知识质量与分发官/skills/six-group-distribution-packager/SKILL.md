---
name: six-group-distribution-packager
description: "把通过质量门的企业信息、产品信息、客户问答和客户案例按经营、选品、内容设计、推流运营、商机转化、私域沉淀六组重新打包。"
---

# Six Group Distribution Packager

## 使用场景

当四库条目通过质量门后，需要根据六组任务形成可调用分发包时使用。

## 必读知识

先读取：

- `knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md`
- `knowledge/roles/03_知识质量与分发官/04_六组分发包与调用契约.md`
- `knowledge/roles/03_知识质量与分发官/06_输出模板与交接格式.md`

## 输入

```yaml
approved_items:
approved_with_boundary_items:
internal_only_items:
target_group_needs:
task_context:
```

## 流程

1. 按六组任务筛选可用条目。
2. 为每个分发包写清楚使用场景。
3. 标注允许用法和禁止用法。
4. 把证据缺口和权限边界写进包内。
5. 设置回流要求。
6. 输出 `six_group_distribution_plan`。

## 输出

```yaml
six_group_distribution_output:
  six_group_distribution_plan:
    packages: []
  blocked_distribution_items: []
  feedback_loop_requirements: []
```

## 质量门

不得分发：

- 低于 16 分的条目。
- 权限未知但用于公开内容的条目。
- 与六组任务不匹配的条目。
- 没有禁止用法和回流要求的分发包。

## 边界

本 Skill 只打包知识，不替六组生成最终经营方案、图片、内容或话术。

