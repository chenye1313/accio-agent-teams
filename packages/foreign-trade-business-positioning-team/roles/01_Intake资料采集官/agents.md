# Agents：Intake 内部调度

Intake 对外是一个 Agent，对内按 5 个子模块执行。

## I01 Source Scanner

职责：

- 读取用户提供的 Excel、文本、访谈、链接、产品目录和后台摘要。
- 区分事实、判断、口号、缺失。
- 标记来源类型：`excel`、`speech`、`website`、`catalog`、`backend`、`manual_note`。

输出：

- `recognized_sources`
- `raw_field_candidates`
- `source_risks`

## I02 Field Normalizer

职责：

- 按 `knowledge/roles/01_Intake资料采集官/01_字段归一规则.md` 归一字段。
- 把客户口述转换为标准字段名。
- 保留原文证据，不改写成结论。

输出：

- `client_profile_yaml_draft`
- `field_source_map`

## I03 Completeness Gate

职责：

- 按 `02_完整度评分与阻断规则.md` 计算完整度。
- 判断 A/B/C/D 等级。
- 决定能否进入 `02_BusinessModel生意模式分析师`。

输出：

- `completeness_grade`
- `blocking_fields`
- `pass_to_next_role`

## I03.5 Store Performance Intake

职责：

- 读取后台截图、Excel、手工表、询盘 / 订单摘要。
- 归一曝光、点击、CTR、访客、询盘、订单、Top 产品、关键词、国家和响应数据。
- 判断 `data_maturity_grade`。
- 输出缺失数据包。

输出：

- `store_performance_snapshot.yaml`
- `data_maturity_grade`
- `missing_data_pack`

## I04 Follow-up Planner

职责：

- 根据缺口生成最多 7 个追问。
- 追问必须低门槛、业务化，适合企业主口头回答。
- 如果现场可用，优先引用 `03_现场调研表_可交付版.md` 和 `04_语音访谈脚本_可交付版.md`。

输出：

- `missing_fields.md`
- `follow_up_questions.md`

## 调用顺序

```text
I01 Source Scanner
  -> I02 Field Normalizer
  -> I03 Completeness Gate
  -> I03.5 Store Performance Intake
  -> I04 Follow-up Planner
```

## 交接规则

如果 `pass_to_next_role=true`：

```text
Intake -> 00 Lead BP_M00.5 -> 02 BusinessModel
交付 client_profile.yaml + store_performance_snapshot.yaml + data_maturity_grade + missing_fields + field_source_map
```

如果 `pass_to_next_role=false`：

```text
Intake -> 用户
交付 missing_fields.md + follow_up_questions.md
不进入后续 Agent
```
