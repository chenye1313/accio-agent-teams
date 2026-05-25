---
name: acio-demo-loop-orchestrator
description: "现场演示企业知识库基座到 aCIO 闭环时使用：固定资料进入、四库主表、内容应用、询盘转化、回流记录的演示顺序和质量门。"
---

# aCIO Demo Loop Orchestrator

## 使用场景

当用户要在讲课、培训、客户现场或售前演示中展示 Accio/aCIO 闭环时使用。

本 Skill 不负责编造客户资料，也不直接做真实后台提交。它负责把演示稳定地编排成：

```text
资料包 -> 企业知识库基座 -> 四库 + 五张主表 -> 内容应用 -> 询盘转化 -> 回流记录
```

## 必读

先读取：

- `output/11_Accio现场演示与aCIO闭环实现方案.md`
- `output/Accio现场演示样例包/README.md`
- `knowledge/roles/00_Lead知识资产总控/08_内容资产生产线与应用路由.md`

## 输入

```yaml
demo_mode: "local_sample/live_client/hybrid"
source_package_path: ""
audience: "老板/外贸负责人/业务/运营/混合"
demo_goal: "讲逻辑/跑样例/客户售前/内部培训"
available_permissions:
  browser: false
  connectors: []
  mcp: []
privacy_requirement: ""
```

## 标准演示顺序

1. 先确认资料包：公司资料、产品表、询盘、报价规则、交易反馈。
2. 调用企业知识库基座，生成四库摘要。
3. 调用五张主表构建：产品、客户询盘、报价、交付、合规。
4. 调用内容应用路由：商详、FAQ、品宣、询盘素材。
5. 调用询盘转化闭环：评分、首响、人工确认、跟进。
6. 输出回流记录：新问题、新异议、新案例线索、新交易数据。
7. 输出老板版讲解：这一步解决什么经营问题。

## 输出

```yaml
demo_loop_output:
  status: "ready/pass_with_gap/blocked"
  demo_path:
    source_package:
    knowledge_base_foundation:
    master_tables:
    content_application:
    inquiry_conversion:
    feedback_loop:
  visible_results:
    - "四库摘要"
    - "五张主表草稿"
    - "FAQ with question/answer/application_scenarios"
    - "结构化商详 Brief"
    - "询盘评分与英文首响"
    - "回流记录"
  missing_inputs: []
  risk_controls: []
  talk_track: ""
```

## 质量门

必须 `blocked`：

- 没有资料包路径。
- 没有隐私边界。
- 只生成文案，没有生成四库或主表。
- FAQ 没有 `question / answer / application_scenarios`。
- 没有展示回流记录。

允许 `pass_with_gap`：

- 真实 Browser/Connectors/MCP 未接入，但本地样例包可以完整演示。
- 交易数据是样例数据，但已标注 demo。
- 后台写入动作只展示草稿和审批，不真实提交。

