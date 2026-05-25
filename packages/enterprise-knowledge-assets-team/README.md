# 企业知识库基座 Team

版本：v0.1  
定位：外贸 AI 经营系统的企业知识库基座，负责把企业原始资料、老板经验、销售对话、客户录音、PPT/PDF 和平台数据，构建成六组可调用的企业知识库与内容养料。

## 1. 一句话

企业不是先缺 Agent，而是先缺可被 Agent 调用的企业知识库基座。

企业知识库基座的任务是把零散资料整理成四库：

```text
企业信息库
产品信息库
客户问答库
客户案例库
```

方法经验不单列成第五库，先内沉在案例、问答和组织实践标签里。

在四库之上，企业知识库基座还必须输出一层“内容应用路由表”，把知识资产转成可被 Accio、阿里国际站、社媒和独立站反复调用的内容养料：

```text
语音沟通 / 老板访谈 / 客户访谈 / 展会交流 / 询盘聊天 / 企业资料 / 交易数据
  -> 四库
  -> 品牌品宣 / 产品表达 / QAS问答 / 案例证据 / 场景方案
  -> 商详 / FAQ / 询盘跟进 / 对外品宣 / 推广内容 / 社媒独立站
  -> 新问题、新案例、新交易数据回流
```

## 2. 角色结构

```text
00_Lead知识资产总控
  -> 01_资料接收与托管师
  -> 02_知识资产构建师
  -> 03_知识质量与分发官
  -> 六组数字化经营团队
```

| 角色 | 责任 | 核心产物 |
|---|---|---|
| `00_Lead知识资产总控` | 定标准、定流程、定质量门、定六组调用边界 | 四库建设方案、任务编排、最终交付包 |
| `01_资料接收与托管师` | 接收资料、来源登记、脱敏、权限和路由 | 脱敏资料包、来源索引、权限标签 |
| `02_知识资产构建师` | 把资料拆成四库候选条目 | 企业信息、产品信息、客户问答、客户案例候选 |
| `03_知识质量与分发官` | 证据分级、AI-Slop 扫描、六组分发、回流管理 | 通过条目、待验证条目、分发包、更新请求 |

## 3. 标准执行顺序

```text
客户资料进入
  -> 00 总控判断任务范围
  -> 脚本优先执行层做目录 / 页码 / ID / 引用 / schema / 微任务拆分
  -> 01 托管师建立来源索引和脱敏资料包
  -> 02 构建师拆成四库候选条目，并标注内容应用路由
  -> 03 分发官做证据、权限、质量和 AI-Slop 检查
  -> 00 总控确认最终分发策略和内容应用包
  -> 六组调用
  -> 六组回流新问题、新案例、新证据
```

## 3.2 现场演示与 aCIO 闭环技能

对讲课和客户演示，企业知识库基座不只输出四库，还要输出可见的 aCIO 闭环。

新增三类总控技能：

| Skill | 用途 |
|---|---|
| `acio-demo-loop-orchestrator` | 固定现场演示顺序：资料包、四库、五张主表、内容应用、询盘转化、回流记录 |
| `business-master-table-builder` | 把产品、询盘、报价、交付、合规整理成五张主表 |
| `inquiry-conversion-loop` | 基于四库和主表生成询盘评分、英文首响、人工确认清单、7/14/30 天跟进和回流项 |

资料包仍然必须先提供。Skill 负责“怎么处理、怎么判断、输出什么”，不能替代企业原始资料。

## 3.1 脚本优先原则

全靠 AI 跑资料流水线会慢、不稳定、不可复现。企业知识库基座新增脚本优先执行层：

```text
可重复工程动作 -> 脚本
语义抽象与判断 -> AI
```

脚本负责：资料清单、页码字数、目录树、批次拆分、ID 唯一、引用闭合、source 字段、quote 长度、schema 字段、空目录和半成品检查。

AI 负责：原理/框架/案例/术语/问答的语义抽取、同类合并、价值判断、证据裁决、口吻迁移和 AI-Slop 审查。

语音、访谈和线下沟通不得只做转写稿，必须继续抽取：

- `brand_claims`：品牌主张、企业故事、工厂实力。
- `product_selling_points`：产品卖点、适用买家、使用场景。
- `buyer_questions`：客户真实问题。
- `answers`：销售、老板或客服给出的回答。
- `case_signals`：案例线索、成交过程、交付结果。
- `proof_points`：证书、交易、客户反馈、平台数据。
- `risk_or_internal_only`：不能公开或需要验证的内容。

团队脚本：

```bash
python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py inventory --kb-root output/读书知识库/内容红利
python3 agent-ready/Teams/企业知识资产中心Team/scripts/knowledge_pipeline_tools.py check --kb-root output/读书知识库/内容红利
```

单次 AI 任务上限：

```yaml
raw_sections: 1
libraries: 1
max_new_items: 5
```

## 4. 四库最小字段

| 知识库 | 最小字段 |
|---|---|
| 企业信息库 | `company_profile`、`capabilities`、`certifications`、`service_scope`、`advantages`、`evidence` |
| 产品信息库 | `product_line`、`sku`、`features`、`use_cases`、`customization`、`delivery`、`proof` |
| 客户问答库 | `question`、`buyer_context`、`answer`、`answer_structure`、`application_scenarios`、`objection_type`、`tags`、`question_keywords`、`source`、`recommended_usage` |
| 客户案例库 | `buyer_type`、`problem`、`conversation_summary`、`solution`、`result`、`reusable_method`、`evidence_level` |

## 4.1 内容应用路由字段

```yaml
content_application_route:
  source_library: "enterprise_info/product_info/customer_qa/customer_case"
  content_layer: "enterprise_strength/brand_promotion/product_expression/buyer_qa/trust_evidence/scenario_solution"
  source_format: "document/voice_transcript/offline_interview/chat_record/backend_data"
  application_target:
    - "alibaba_knowledge_base"
    - "structured_product_detail"
    - "faq_pack"
    - "inquiry_followup"
    - "brand_promotion"
    - "marketing_content"
    - "social_independent_site"
  public_or_internal_boundary: "public/internal_only/needs_validation"
```

## 5. 质量门

每条知识必须有：

- `source_id`
- `source_type`
- `permission_status`
- `evidence_level`
- 四库归属
- 使用边界
- 客户问答必须有具体问题、可执行答案和应用场景
- 语音和访谈抽取必须保留说话人、场景和时间点
- 内容应用必须标注公开 / 内部 / 待验证边界

禁止：

- 无来源结论。
- 未脱敏客户隐私。
- 权限未知但对外公开。
- 把老板口述经验写成确定事实。
- 把方法经验单列成对外第五库。
- 客户问答只有答案，没有具体问题、应用场景、标签和关键词。
- 老板口述或销售经验未经证据校验就直接生成对外品宣。
- 线下访谈只保存转写稿，没有转成 QAS、案例、品牌或产品内容资产。
- 没有回流要求就分发给六组。

## 6. 文件地图

```text
roles/
  00_Lead知识资产总控/
  01_资料接收与托管师/
  02_知识资产构建师/
  03_知识质量与分发官/

knowledge/roles/
  00_Lead知识资产总控/
  01_资料接收与托管师/
  02_知识资产构建师/
  03_知识质量与分发官/

scripts/
  knowledge_pipeline_tools.py
```

每个角色目录包含：

```text
README.md
identity.md
soul.md
agents.md
memory.md
user.md
knowledge_refs.yaml
skills/*/SKILL.md
```

## 7. 当前完成状态

```yaml
team_status:
  roles_built:
    - "00_Lead知识资产总控"
    - "01_资料接收与托管师"
    - "02_知识资产构建师"
    - "03_知识质量与分发官"
  private_knowledge_built: true
  skills_built: true
  knowledge_refs_checked: true
  agent_runtime_connected: false
```

当前只完成蓝图、角色文件、私有知识库和 Skills 文件搭建；还没有承诺这些角色已经接入真实 Agent runtime、阿里后台或 OKKI。

## 8. Output 产物目录

所有新运行产物统一写入本 Team 的 `output/` 目录，避免混在 `roles/`、`knowledge/` 或脚本目录中。

推荐结构：

```text
output/
├── README.md
├── samples/                         # 脱敏样例
└── runs/
    └── <YYYYMMDD-HHMMSS_client-slug>/
        ├── inputs/                  # 原始资料清单、脱敏说明、客户授权边界
        ├── roles/                   # 各角色中间产物
        │   ├── 01_intake/
        │   ├── 02_builder/
        │   └── 03_quality/
        ├── final/                   # 四库交付包、内容应用路由、最终说明
        ├── qa/                      # 质量门、权限门、AI-Slop 扫描、返工记录
        └── run_manifest.yaml        # 本次运行索引
```

角色产物建议：

| 角色 | 推荐 output 子目录 | 典型产物 |
|---|---|---|
| `01_资料接收与托管师` | `roles/01_intake/` | `source_index.yaml`、`anonymized_material_pack/`、`permission_tags.yaml` |
| `02_知识资产构建师` | `roles/02_builder/` | `enterprise_info.yaml`、`product_info.yaml`、`customer_qa.yaml`、`customer_cases.yaml` |
| `03_知识质量与分发官` | `roles/03_quality/` | `evidence_quality_report.md`、`ai_slop_scan.md`、`distribution_pack.yaml` |
| `00_Lead知识资产总控` | `final/` 和 `qa/` | `knowledge_asset_report.md`、`final_delivery_manifest.yaml`、`feedback_loop_plan.md` |
