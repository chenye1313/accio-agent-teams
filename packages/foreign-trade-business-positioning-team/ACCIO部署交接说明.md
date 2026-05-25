# ACCIO 部署交接说明：外贸经营定位专家 Team 数据化升级

版本：v0.1  
日期：2026-05-23  
交接对象：负责在 ACCIO / Accio Work 中重新部署、更新或调试本 Team 的同学

## 1. 一句话说明本次变化

这次不是新增第 9 个 Agent，而是把原来的“经营定位报告生成器”升级成“经营数据驱动的经营分析系统”。

核心变化：

```text
原流程：
资料采集 -> 生意模式 -> 买家分析 -> 能力映射 -> 定位 -> 页面表达 -> 指标质检

新流程：
资料采集 -> 经营数据诊断与决策证据门 -> 生意模式 -> 买家分析 -> 能力映射 -> 定位 -> 页面表达 -> 指标基线与复盘 -> Lead 交付
```

以后只有公开店铺链接时，只能输出“假设版”。必须接入后台、询盘、成交、SKU 等经营数据后，才能输出更强的经营判断。

## 2. 请部署方重点替换 / 新增的文件

以此文件夹为部署根目录：

```text
agent-ready/Teams/外贸经营定位专家Team/
```

### A. 必须替换的共享知识库

请整体替换或同步：

```text
knowledge/shared/
```

其中这 4 个文件是本轮核心：

| 文件 | 用途 |
|---|---|
| `knowledge/shared/02_输入字段与完整度.md` | 增加后台、询盘、成交、SKU、页面、竞品字段；增加 D0-D4 数据成熟度和脱敏规则 |
| `knowledge/shared/03_方法路由卡.md` | 新增 `BP_M00.5 经营数据诊断与决策证据门` |
| `knowledge/shared/05_经营罗盘指标映射.md` | 增加上线前基线和 7/30/90 天复盘 |
| `knowledge/shared/07_经营数据证据门.md` | 新增数据可信度、数据到决策矩阵、输出降级规则 |

### B. 必须新增 / 更新的 5 个 Skill

请按角色放到对应 Agent 的 Skill 区：

| 角色 | Skill 路径 | 作用 |
|---|---|---|
| `01_Intake资料采集官` | `roles/01_Intake资料采集官/skills/store-performance-intake/SKILL.md` | 接入后台截图、Excel、手工表，输出 `store_performance_snapshot.yaml` |
| `03_BuyerJTBD买家任务分析师` | `roles/03_BuyerJTBD买家任务分析师/skills/inquiry-sales-segmenter/SKILL.md` | 分析询盘和成交，校准真实买家 |
| `02_BusinessModel生意模式分析师` | `roles/02_BusinessModel生意模式分析师/skills/sku-performance-mapper/SKILL.md` | 分析 SKU 曝光、询盘、成交、毛利，判断主推产品 |
| `04_SupplyMapping供给能力映射师` | `roles/04_SupplyMapping供给能力映射师/skills/market-competitor-scanner/SKILL.md` | 抓取 / 整理竞品，判断行业通用说法和错位机会 |
| `00_Lead经营定位总控` | `roles/00_Lead经营定位总控/skills/decision-sufficiency-gate/SKILL.md` | 判断结论是可决策、可讨论、仅假设还是阻断 |

### C. 必须同步的 Team 运行文件

请同步：

```text
README.md
TEAM.md
workflow.md
handoff_contract.yaml
quality_gates.md
knowledge_mount.yaml
knowledge_load_plan.md
shared_knowledge.md
platform_upload_pack.md
delivery_manifest.yaml
商家上手说明.md
tests/sweethome_data_upgrade_replay.md
```

## 3. 部署时要改的 Team 调度逻辑

### 旧调度

```text
Intake
  -> BusinessModel
  -> BuyerJTBD
  -> SupplyMapping
  -> Differentiation
  -> Expression
  -> MetricQualityGate
  -> Lead
```

### 新调度

```text
Intake
  -> Lead / BP_M00.5 经营数据诊断与决策证据门
  -> BusinessModel
  -> BuyerJTBD
  -> SupplyMapping
  -> Differentiation
  -> Expression
  -> MetricQualityGate
  -> Lead
```

### 新增硬规则

1. `Intake` 不再只输出 `client_profile.yaml`，还要尽量输出：
   - `store_performance_snapshot.yaml`
   - `data_maturity_grade`
   - `missing_data_pack`

2. `Lead` 必须在核心判断前执行：
   - `decision-sufficiency-gate`

3. 如果只有公开店铺链接：
   - 只能输出 `hypothesis_only`
   - 客户版要翻译成：“这是第一版方向判断，补后台和询盘后再校准”

4. 如果没有上线前基线：
   - 不能承诺指标提升比例
   - 只能写“建议观察指标”

5. 客户版禁止出现：
   - `M00 / M01`
   - `JTBD`
   - `PASS_WITH_GAP`
   - `weak_hypothesis`
   - `hypothesis_only`
   - `decision_ready`
   - `delivery_verdict`

## 4. 每个角色需要知道的新职责

| 角色 | 新增职责 |
|---|---|
| Lead | 增加决策证据充分性门；判断结论能不能下；客户版先于内部版 |
| Intake | 接入后台、询盘、成交、SKU 数据；判断 D0-D4 数据成熟度 |
| BusinessModel | 必须看 SKU、订单、毛利、复购，不只看客户口述 |
| BuyerJTBD | 必须优先用询盘和成交文本校准真实买家 |
| SupplyMapping | 增加竞品参照，但公开抓取不能替代自有经营数据 |
| Differentiation | 定位必须说明是可决策、可讨论还是仅假设 |
| Expression | 页面表达要基于可说证据；客户版语言要通俗 |
| MetricQualityGate | 从后置质检升级为上线前基线 + 7/30/90 天复盘 |

## 5. 商家需要补充的数据模板

部署时建议把下面这段作为商家资料收集表。

```text
请尽量提供以下资料，能脱敏：

1. 店铺后台数据
   - 近 30/90 天曝光、点击、CTR、访客、询盘、订单
   - Top 浏览产品、Top 询盘产品、Top 搜索关键词、Top 国家
   - 广告花费、平均点击成本、首响时间

2. 询盘数据
   - 最近 20 条询盘
   - 保留国家、买家类型、采购用途、采购量、成交状态
   - 客户名、邮箱、电话可以删除

3. 成交 / SKU 数据
   - 哪些产品带来询盘
   - 哪些产品成交
   - 哪些产品利润更好
   - 哪些客户复购

4. 页面素材
   - 首页首屏截图
   - 产品详情页截图
   - 证书、案例、评价、装柜、交付过程图片

5. 竞品资料
   - 3-5 个竞品链接
   - 核心关键词搜索结果截图
```

## 6. 给部署同学的交代话术

可以直接复制这段发给 ACCIO 部署同学：

```text
这次请不要新增第 9 个 Agent，仍然用原来的 8 个角色。

本次升级的核心是：在原经营定位 Team 里加入“经营数据诊断与决策证据门”。

请按新文件替换 Team 包：
agent-ready/Teams/外贸经营定位专家Team/

重点同步：
1. knowledge/shared/02_输入字段与完整度.md
2. knowledge/shared/03_方法路由卡.md
3. knowledge/shared/05_经营罗盘指标映射.md
4. knowledge/shared/07_经营数据证据门.md
5. 5 个新增 Skill：
   - store-performance-intake
   - inquiry-sales-segmenter
   - sku-performance-mapper
   - market-competitor-scanner
   - decision-sufficiency-gate

调度流程要改成：
Intake -> BP_M00.5 数据诊断与证据门 -> BusinessModel -> BuyerJTBD -> SupplyMapping -> Differentiation -> Expression -> MetricQualityGate -> Lead

硬规则：
- 只有公开店铺链接时，只能输出假设版，不能写成最终经营决策。
- 后台、询盘、成交、SKU 数据优先于公开竞品抓取。
- 客户版不能出现内部状态码、Agent 编号、证据等级黑话。
- 没有上线前基线，不能承诺指标提升比例。

部署后请用 tests/sweethome_data_upgrade_replay.md 做验收。
```

## 7. 部署验收清单

部署完成后，请检查：

```yaml
deployment_checklist:
  shared_knowledge_has_07_data_evidence_gate: true
  workflow_has_bp_m00_5: true
  five_new_skills_installed: true
  lead_can_run_decision_sufficiency_gate: true
  intake_can_output_store_performance_snapshot: true
  business_model_can_read_sku_performance_map: true
  buyer_jtbd_can_read_inquiry_segments: true
  supply_mapping_can_read_market_competitor_scan: true
  metric_gate_has_baseline_and_7_30_90_review: true
  customer_version_removes_internal_jargon: true
  sweethome_data_upgrade_replay_passed: true
```

## 8. 验收用例

使用：

```text
tests/sweethome_data_upgrade_replay.md
```

最低验收：

1. 只给公开店铺链接时，输出降级为假设版。
2. 加后台样例后，能生成 `store_performance_snapshot.yaml`。
3. 加询盘样例后，能校准真实买家。
4. 加 SKU 样例后，能校准主推产品和生意模式。
5. 客户版没有内部黑话。
6. 内部版保留证据等级、红线、假设披露和返工路由。

