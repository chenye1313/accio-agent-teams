# Knowledge Load Plan：外贸经营定位专家 Team

版本：v0.2

日期：2026-05-23

## 结论

不要让 8 个 Agent 全部无差别共享一个大知识库。

正确装配方式是：

```text
一个 Team 共享知识底座
  + 每个角色自己的必加载知识切片
  + 案例库按需读取
  + 原始书籍 / PDF 深读材料只在需要仲裁或追溯时读取
```

如果平台只能给 Team 绑定一个知识库文件夹，就把本文件列出的所有材料放进同一个 Team 知识库，但每个角色必须按自己的“加载清单”调用，禁止全量读完再回答。

如果平台支持每个 Agent 单独绑定知识库，则使用：

```text
shared_common + role_private + case_memory
```

## 四层知识库

| 层级 | 名称 | 作用 | 是否所有角色读取 |
|---|---|---|---|
| K0 | Team 共享底座 | 统一输入、方法路由、报告模板、质量门、经营指标 | 是 |
| K1 | 角色私有知识切片 | 每个角色完成自己判断所需的方法、模板和证据 | 否 |
| K2 | 案例记忆 | 用案例 1 / 2 校准输出形态和验收标准 | 按需 |
| K3 | 深读原始材料 | 书籍、PDF、OCR、深读索引，用于追溯和复杂仲裁 | 按需 |

## K0：Team 共享底座

所有角色都可以读取，但读取目的不同。

| 文件 | 用途 | 主要消费者 |
|---|---|---|
| `knowledge-base/经营定位/01_能力问题与验收.md` | 红线、能力问题、评分规则 | Lead、MetricQualityGate、全部角色 |
| `knowledge-base/经营定位/02_输入字段_schema.md` | 客户输入字段、最小 12 字段、访谈追问 | Intake、Lead、全部角色 |
| `knowledge-base/经营定位/cards_index.yaml` | BP_M00-BP_M07 机器可读方法路由 | Lead、全部角色 |
| `knowledge-base/经营定位/04_经营定位报告模板.md` | 最终报告结构 | Lead、Expression、MetricQualityGate |
| `knowledge-base/经营罗盘/00_指标库.md` | 指标影响和复盘周期 | MetricQualityGate、Lead、Expression |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/02_输入字段与完整度.md` | 经营数据字段、数据成熟度、脱敏规则 | Intake、Lead、全部角色 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/03_方法路由卡.md` | 含 BP_M00.5 的新版方法路由 | Lead、全部角色 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 数据可信度、数据到决策矩阵、输出等级 | Lead、Intake、BusinessModel、BuyerJTBD、MetricQualityGate |
| `agent-ready/Teams/外贸经营定位专家Team/handoff_contract.yaml` | 角色交接字段契约 | Lead、全部角色 |
| `agent-ready/Teams/外贸经营定位专家Team/quality_gates.md` | Team 红线与验收 | Lead、MetricQualityGate |

## K1：角色私有知识切片

### 00 Lead 经营定位总控

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营定位/01_能力问题与验收.md` | 判断是否能交付 |
| 必加载 | `knowledge-base/经营定位/cards_index.yaml` | 调度 BP_M00-BP_M07 |
| 必加载 | `knowledge-base/经营定位/04_经营定位报告模板.md` | 汇总最终报告 |
| 必加载 | `knowledge-base/经营罗盘/00_指标库.md` | 指标绑定 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 决策证据充分性 |
| 按需 | `knowledge-base/经营定位/00_知识库重构蓝图.md` | 仲裁 P/C/D/S/I 五域缺口 |
| 按需 | `process/deep-review/02_书籍深读第一轮_经营定位映射.md` | 方法论冲突时追溯 |

### 01 Intake 资料采集官

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营定位/02_输入字段_schema.md` | 字段归一和完整度判断 |
| 必加载 | `knowledge-base/经营定位/06_商家现场调研表.md` | 现场采集表 |
| 必加载 | `knowledge-base/经营定位/07_语音访谈脚本.md` | 语音访谈追问 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/02_输入字段与完整度.md` | 经营数据字段与数据成熟度 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 输出降级规则 |
| 按需 | `process/cases/case2_hotblizzard_profile.yaml` | 输入样例 |
| 按需 | `knowledge-base/经营定位/05_外贸Agent资料补缺映射.md` | 判断外贸 Agent 后续缺口 |

### 02 BusinessModel 生意模式分析师

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营定位/03_方法模块索引.yaml` | M01 生意模式模块 |
| 必加载 | `process/deep-review/book-indexes/B04_商业的本质 (杰克•韦尔奇 [杰克•韦尔奇]) (z-library.sk, 1.md` | 经营目标、使命、取舍 |
| 必加载 | `process/deep-review/book-indexes/B05_商业设计元素周期表.md` | 商业构成要素 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 用 SKU / 订单证据约束模式判断 |
| 按需 | `process/deep-review/book-indexes/B06_绝对成交：一页纸营销计划：九宫格思维教你持续开发客户，实现业绩倍增 (超级畅销书.md` | 客户、渠道、转化路径 |
| 按需 | `process/cases/case1_sweethome_extract.md` | 成熟供应链案例 |
| 按需 | `process/cases/case2_hotblizzard_profile.yaml` | 品牌孵化供应链案例 |

### 03 BuyerJTBD 买家任务分析师

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `process/deep-review/book-indexes/B01_Competing Against Luck (Clayton M. Chris.md` | JTBD 需求不变量 |
| 必加载 | `process/deep-review/book-indexes/B03_JTBD Book Updated 121119 (Lindsay Ulwick.md` | ODI 成功指标 |
| 必加载 | `knowledge-base/经营定位/02_输入字段_schema.md` | 买家字段、Job 字段 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 询盘证据优先级和假设降级 |
| 按需 | `process/cases/case2_hotblizzard_profile.yaml` | B2B2C 买家任务样例 |

### 04 SupplyMapping 供给能力映射师

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营定位/02_输入字段_schema.md` | 供给能力字段 |
| 必加载 | `process/cases/case1_sweethome_extract.md` | 能力证据和 7 屏落地样例 |
| 必加载 | `process/cases/case2_hotblizzard_profile.yaml` | 定制能力、认证、交付周期样例 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 公开竞品资料的证据边界 |
| 按需 | `process/deep-review/03_Acciowork外贸Agent_PDF审阅.md` | 外贸业务系统和 Skill 补缺 |

### 05 Differentiation 差异化定位师

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `process/deep-review/book-indexes/B08_重新定位：定位之父杰克·特劳特封笔之作（珍藏版）定位经典丛书 ( etc.) (.md` | 心智抢词、取舍、再定位 |
| 必加载 | `process/deep-review/book-indexes/B07_超级符号就是超级创意席卷中国市场10年的华与华战略营销创意方法 (华杉, 华楠).md` | 信任前置、超级符号、超级话语 |
| 必加载 | `knowledge-base/经营定位/cards_index.yaml` | BP_M04 差异化定位规则 |
| 按需 | `process/deep-review/02_书籍深读第一轮_经营定位映射.md` | 特劳特 vs 华与华冲突仲裁 |
| 按需 | `process/cases/case1_sweethome_extract.md` | 成熟品类定位样例 |

### 06 Expression 表达落地师

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营定位/04_经营定位报告模板.md` | 报告和表达结构 |
| 必加载 | `process/cases/case1_sweethome_extract.md` | 7 屏表达样例 |
| 必加载 | `knowledge-base/经营定位/05_外贸Agent资料补缺映射.md` | 外贸场景、Skill 和页面补缺 |
| 必加载 | `process/deep-review/book-indexes/B07_超级符号就是超级创意席卷中国市场10年的华与华战略营销创意方法 (华杉, 华楠).md` | 语言钉子、视觉锤、信任表达 |
| 按需 | `process/deep-review/book-indexes/B06_绝对成交：一页纸营销计划：九宫格思维教你持续开发客户，实现业绩倍增 (超级畅销书.md` | CTA、转化路径 |

### 07 MetricQualityGate 经营罗盘质检官

| 类型 | 文件 | 用途 |
|---|---|---|
| 必加载 | `knowledge-base/经营罗盘/00_指标库.md` | 指标影响判断 |
| 必加载 | `knowledge-base/经营定位/01_能力问题与验收.md` | 红线质检 |
| 必加载 | `knowledge-base/经营定位/04_经营定位报告模板.md` | 检查报告完整度 |
| 必加载 | `tests/case2_hotblizzard_replay.md` | 回放验收标准 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/05_经营罗盘指标映射.md` | 上线前基线和 7/30/90 天复盘 |
| 必加载 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 缺基线时的输出边界 |
| 按需 | `output/经营定位专家小闭环/case2_run_trace.md` | 决策链路追溯 |

## K2：案例记忆

| 文件 | 角色 | 用途 |
|---|---|---|
| `process/cases/case1_sweethome_extract.md` | SupplyMapping、Differentiation、Expression | 成熟输出样例、7 屏 brief、能力证据 |
| `process/cases/case2_hotblizzard_profile.yaml` | Intake、BusinessModel、BuyerJTBD | 输入表样例、品牌孵化供应链 |
| `output/经营定位专家小闭环/case2_business_positioning_report.md` | Lead、MetricQualityGate | P0 演示报告 |
| `tests/case2_hotblizzard_replay.md` | Lead、MetricQualityGate | 验收回放 |
| `agent-ready/Teams/外贸经营定位专家Team/tests/sweethome_data_upgrade_replay.md` | Lead、MetricQualityGate | 数据化升级验收 |

## K3：深读原始材料

这些材料不应该默认全量塞给每个 Agent。只有在需要方法论解释、冲突仲裁、二次深化时读取。

| 文件 / 目录 | 读取时机 |
|---|---|
| `process/deep-review/02_书籍深读第一轮_经营定位映射.md` | Lead 需要解释方法论组合或冲突 |
| `process/deep-review/03_Acciowork外贸Agent_PDF审阅.md` | 需要把经营定位接到外贸 Agent 全链路 |
| `process/deep-review/book-indexes/` | 某角色需要追溯书籍证据 |
| `process/deep-review/acciowork_agent_pdf_ocr/` | 需要回查 PDF 原文 OCR |
| `process/deep-review/book-indexes-json/` | 后续脚本化检索或插件化时使用 |

## 平台装配策略

### 情况 A：平台只支持一个 Team 知识库

上传 / 绑定一个 Team 知识库，至少包含：

```text
knowledge-base/经营定位/
knowledge-base/经营罗盘/
process/cases/
process/deep-review/02_书籍深读第一轮_经营定位映射.md
process/deep-review/03_Acciowork外贸Agent_PDF审阅.md
process/deep-review/book-indexes/
agent-ready/Teams/外贸经营定位专家Team/knowledge_load_plan.md
agent-ready/Teams/外贸经营定位专家Team/knowledge_mount.yaml
agent-ready/Teams/外贸经营定位专家Team/tests/
```

同时在每个角色提示词中写死：只读取自己的 K1 清单，不允许全量泛读。

### 情况 B：平台支持每个 Agent 独立知识库

每个 Agent 绑定：

```text
K0 共享底座
+ 该角色 K1 私有知识切片
+ 需要时按需读取 K2 / K3
```

这是推荐形态，Token 更稳，角色边界更清楚。

### 情况 C：要做成 Skill / 插件

优先脚本化这些知识：

| 优先级 | 文件 | 可脚本化用途 |
|---|---|---|
| P0 | `knowledge-base/经营定位/02_输入字段_schema.md` | 输入校验、缺字段追问 |
| P0 | `knowledge-base/经营定位/cards_index.yaml` | 方法路由 |
| P0 | `knowledge-base/经营定位/04_经营定位报告模板.md` | 报告渲染 |
| P0 | `knowledge-base/经营罗盘/00_指标库.md` | 指标影响映射 |
| P0 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/07_经营数据证据门.md` | 决策证据门、输出降级 |
| P1 | `knowledge-base/经营定位/01_能力问题与验收.md` | 质量门打分 |
| P1 | `process/deep-review/book-indexes-json/` | 方法论检索 |

## 禁止规则

1. 禁止 8 个角色都加载所有书籍原文。
2. 禁止把案例输出当作通用模板硬套。
3. 禁止没有客户证据时调用方法论硬写结论。
4. 禁止 Expression 在 Differentiation 未通过时先写页面文案。
5. 禁止 MetricQualityGate 只看格式，不看经营指标。
6. 禁止用公开竞品抓取替代客户自己的后台、询盘、成交和 SKU 数据。

## 当前判断

当前知识库已经足够支撑“经营定位专家小闭环”和 Team 版内部彩排，并已具备数据化升级的输入、证据门和复盘框架。

正式客户交付前还需要补：

1. 更多真实行业案例，至少 3-5 个。
2. 阿里后台字段样例，尤其是流量、询盘、转化和店铺模块。
3. 每个角色输出的失败样例和返工样例。
4. 平台实测记录：单知识库绑定与多 Agent 私有知识库绑定哪种可行。
