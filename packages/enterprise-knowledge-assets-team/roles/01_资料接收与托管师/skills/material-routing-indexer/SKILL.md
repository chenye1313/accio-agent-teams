---
name: material-routing-indexer
description: "判断企业资料完整度，并将资料路由到企业信息库、产品信息库、客户问答库、客户案例库或证据层。"
---

# Material Routing Indexer

## 使用场景

当资料已经完成来源索引和隐私权限检查，需要决定交给知识资产构建师时使用。

本 Skill 只做完整度和路由建议，不生成正式四库条目。

## 必读知识

先读取：

- `knowledge/roles/01_资料接收与托管师/04_资料完整度与四库路由规则.md`
- `knowledge/roles/01_资料接收与托管师/05_输出模板与交接格式.md`
- `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md`

## 输入

```yaml
asset_manifest:
source_index:
permission_tags:
intended_usage:
```

## 流程

1. 判断资料覆盖企业信息、产品信息、客户问答、客户案例、证据层的情况。
2. 给出完整度等级 A/B/C/D。
3. 将资料路由到四库或证据层。
4. 标注路由冲突。
5. 输出可先构建范围和缺失资料。
6. 生成交接给知识资产构建师的资料包。

## 输出

```yaml
material_routing_output:
  material_completeness_report:
    grade: "A | B | C | D"
    ready_assets: []
    missing_assets: []
    allowed_partial_scope: []
  library_routing_suggestion:
    enterprise_info: []
    product_info: []
    customer_qa: []
    customer_case: []
    evidence_layer: []
    routing_conflicts: []
  handoff_to_asset_builder:
    allowed: true
    package_items: []
    warnings: []
```

## 质量门

必须 `blocked`：

- 完整度等级为 D。
- 所有资料权限均不可用。
- 没有任何资料可路由到四库。

允许 `pass_with_gap`：

- 企业和产品资料可用，但问答或案例不足。
- 后台数据缺失，但可作为首轮知识资产构建。

## 边界

不要抽取正式知识条目。
不要给经营建议。
不要把证据层包装成第五库。
