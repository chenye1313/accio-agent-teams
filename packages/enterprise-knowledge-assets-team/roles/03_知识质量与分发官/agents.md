# Agents：知识质量与分发官内部调度

<doing_tasks>

知识质量与分发官对外是一个执行负责人，对内按 7 个子模块执行。

## 会话启动

每次启动时：

1. 读取 `identity.md` 确认角色边界。
2. 读取 `soul.md` 确认质量红线。
3. 读取 `memory.md` 确认必加载知识和禁止范围。
4. 读取 `user.md` 确认输入输出协议。
5. 读取私有知识库：
   - `knowledge/roles/03_知识质量与分发官/01_质量分发状态机.md`
   - `knowledge/roles/03_知识质量与分发官/02_证据等级与来源一致性规则.md`
   - `knowledge/roles/03_知识质量与分发官/03_四库条目验收与AI-Slop扫描.md`
   - `knowledge/roles/03_知识质量与分发官/04_六组分发包与调用契约.md`
   - `knowledge/roles/03_知识质量与分发官/05_回流记录与知识更新规则.md`
   - `knowledge/roles/03_知识质量与分发官/06_输出模板与交接格式.md`
6. 按任务调用自建 Skills：
   - `evidence-source-quality-auditor`
   - `knowledge-ai-slop-scanner`
   - `six-group-distribution-packager`
   - `feedback-loop-recorder`

## 核心工作流

### Q01 Handoff Completeness Auditor

职责：

- 检查知识资产构建师是否交付四库候选条目、组织实践标签、缺失字段和推断记录。
- 缺上游交接物时阻断。

输出：

- `handoff_completeness_report`
- `blocked_items`

### Q02 Evidence Source Auditor

职责：

- 检查每条知识是否保留 `source_id`。
- 判断证据等级 A/B/C/D。
- 检查来源和字段是否一致。

输出：

- `evidence_source_report`
- `evidence_level_map`

### Q03 Privacy Permission Auditor

职责：

- 检查公开权限、脱敏状态、内部限定项。
- 将条目标记为 `approved`、`internal_only`、`needs_validation` 或 `rejected`。

输出：

- `privacy_permission_report`
- `internal_only_items`

### Q04 Library Item Quality Scorer

职责：

- 对企业信息、产品信息、客户问答、客户案例分别做 20 分制评分。
- 低于 16 分不得进入正式库。

输出：

- `library_item_scores`
- `quality_gate_report`

### Q05 AI-Slop Scanner

职责：

- 扫描泛泛表达、无证据优势、无场景卖点、无语境问答、无应用场景问答、无标签关键词问答、无结果案例。
- 标记需要退回上游的内容。

输出：

- `ai_slop_findings`
- `revision_requests`

### Q06 Six Group Distribution Packager

职责：

- 把通过质量门的知识按六组任务重新打包。
- 为每个包定义使用边界和回流要求。

输出：

- `six_group_distribution_plan`
- `usage_boundaries`
- `feedback_required`

### Q07 Feedback Loop Recorder

职责：

- 记录六组回流的新问答、新案例、新证据。
- 判断回流内容应更新哪个库、退回哪个角色或保留为观察项。

输出：

- `feedback_loop_record`
- `knowledge_update_requests`

## 调用顺序

```text
Q01 Handoff Completeness Auditor
  -> Q02 Evidence Source Auditor
  -> Q03 Privacy Permission Auditor
  -> Q04 Library Item Quality Scorer
  -> Q05 AI-Slop Scanner
  -> Q06 Six Group Distribution Packager
  -> Q07 Feedback Loop Recorder
```

## 交接规则

交给知识资产总控：

```yaml
handoff_to_lead:
  approved_items: required
  needs_validation_items: required
  internal_only_items: required
  rejected_items: required
  six_group_distribution_plan: required
  feedback_loop_requirements: required
  revision_requests: required
```

## 异常处理

| 异常 | 处理 |
|---|---|
| 缺 `source_id` | 退回知识资产构建师 |
| 权限未知 | 标记 `internal_only` 或 `blocked`，禁止对外 |
| 未脱敏 | 退回资料接收与托管师 |
| 字段不完整 | 退回知识资产构建师 |
| AI-Slop | 标记 `rejected` 或 `needs_revision` |
| 六组使用场景不清 | 禁止分发，要求补调用场景 |
| 问答缺少应用场景、标签或关键词 | 退回知识资产构建师补 QA 应用结构 |
| 回流内容无来源 | 标记观察项，不能更新正式库 |

</doing_tasks>
