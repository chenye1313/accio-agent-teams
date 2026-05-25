# Memory：知识库基座总控知识加载表

## 必加载：蓝图与执行架构

| 文件 | 用途 |
|---|---|
| `output/05_企业知识资产中心与第0组蓝图.md` | 企业知识库基座定位、四库、质量门、六组调用关系 |
| `output/06_企业知识资产中心角色与元Accio执行架构.md` | 四角色架构、技能装备、交接协议、五文件生成标准 |
| `output/04_外贸AI数字化经营部门蓝图.md` | 六组数字化经营团队总架构 |

## 必加载：总控私有知识库

| 文件 | 用途 |
|---|---|
| `knowledge/roles/00_Lead知识资产总控/01_总控调度状态机.md` | 判断当前阶段、下一步和阻断条件 |
| `knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md` | 定义四库字段、归属规则和方法内沉规则 |
| `knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md` | 定义三个执行角色的交接物、最低标准和返工路由 |
| `knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md` | 定义来源、证据等级、脱敏、公开权限和红线 |
| `knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md` | 定义六组知识包、使用边界和回流协议 |
| `knowledge/roles/00_Lead知识资产总控/06_输出模板与最终交付格式.md` | 定义总控标准输出和老板版摘要 |

## 必挂载：总控自建 Skills

| Skill | 用途 |
|---|---|
| `skills/knowledge-asset-lead-orchestrator/SKILL.md` | 企业知识库基座总控调度、四库策略、角色派工、交接门审查 |
| `skills/knowledge-asset-evidence-gate/SKILL.md` | 来源、证据等级、脱敏、公开权限和可分发状态检查 |
| `skills/six-group-knowledge-dispatcher/SKILL.md` | 将通过质量门的四库知识分发给六组并定义回流 |

## 必加载：前段 Accio 知识整理方法

| 文件 | 用途 |
|---|---|
| `前段ACCIO资料库分类整理/1、术语专项提取.md` | 术语、实体、产品名、行业词统一 |
| `前段ACCIO资料库分类整理/2、案例专项提取.md` | 客户案例卡片化规则 |
| `前段ACCIO资料库分类整理/3、正文知识单元化.md` | 企业事实和产品事实原子化 |
| `前段ACCIO资料库分类整理/4、FAQ 生成与整合.md` | 客户问答库生成和整合 |
| `前段ACCIO资料库分类整理/优秀商业访谈师特质.md` | 组织能力萃取：场景、流程、角色、判断、动作、标准、机制、反馈 |

## 必加载：元 Accio 架构规范

| 文件 | 用途 |
|---|---|
| `/Users/cheyne/Downloads/百度云/Obsidian Vault/2 工作/MMAI 智能体/元Accio架构师/AGENTS.md` | 五阶段团队设计、五文件规范、质量验证 |
| `/Users/cheyne/Downloads/百度云/Obsidian Vault/2 工作/MMAI 智能体/元Accio架构师/SOUL.md` | 架构师核心信念：澄清、搜索、架构、审查、层级 |
| `/Users/cheyne/Downloads/百度云/Obsidian Vault/2 工作/MMAI 智能体/元Accio架构师/MEMORY.md` | Accio 技能分类、MMAI 可复用资产 |

## 四库字段底稿

### 企业信息库

```yaml
enterprise_info:
  company_profile: ""
  capabilities: []
  certifications: []
  service_scope: []
  advantages:
    - claim: ""
      evidence: ""
      evidence_level: ""
  source: {}
  status: "usable / needs_validation / internal_only"
```

### 产品信息库

```yaml
product_info:
  product_line: ""
  sku: ""
  features: []
  use_cases: []
  customization: []
  delivery:
    moq: ""
    sampling_cycle: ""
    production_cycle: ""
  proof: []
  status: "usable / needs_validation / internal_only"
```

### 客户问答库

```yaml
customer_qa:
  question: ""
  buyer_context:
    country: ""
    buyer_type: ""
    stage: ""
  answer: ""
  answer_structure:
    core_point: ""
    facts: []
    cases: []
    action_steps: []
    limits: []
    reusable_formula: ""
  application_scenarios: []
  objection_type: ""
  tags: []
  question_keywords: []
  source: {}
  recommended_usage: []
  status: "usable / needs_validation / internal_only"
```

### 客户案例库

```yaml
customer_case:
  buyer_type: ""
  problem: ""
  conversation_summary: ""
  solution: ""
  result: ""
  reusable_method: []
  evidence_level: "A/B/C/D"
  source: {}
  public_permission: "public / anonymized / internal_only"
  status: "usable / needs_validation / internal_only"
```

## 证据等级

```yaml
evidence_level:
  A: "有后台数据、成交记录、合同/订单、客户反馈等强证据"
  B: "有文档、聊天、录音、案例复盘等可追溯证据"
  C: "有老板或销售口述，但缺少外部或数据验证"
  D: "无明确来源，只能作为待验证线索"
```

## 分发包记忆

| 六组 | 默认分发包 |
|---|---|
| 经营定位组 | 企业优势包、客户问题包、案例证据包、经营缺口包 |
| 选品定品组 | 产品线包、SKU 表、客户需求包、案例中的产品反馈 |
| 内容表达与设计组 | 企业故事包、产品卖点包、案例信任包、FAQ 内容包 |
| 推流运营组 | 产品标签包、关键词线索包、客户问题包、案例场景包 |
| 商机转化组 | 异议处理包、报价问答包、案例证明包、产品交付包 |
| 私域沉淀组 | 客户标签包、复购线索包、客户反馈包、新案例回收表 |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `agent-ready/Teams/外贸经营定位专家Team/roles/00_Lead经营定位总控/*` | 需要参考既有 Lead 总控文件结构 |
| `knowledge-base/经营定位/*` | 需要确认经营定位组如何调用企业知识库基座产物 |
| `agent-ready/Teams/外贸经营定位专家Team/knowledge/shared/*` | 需要复用现有质量门、证据门或交接格式 |

## 不加载

默认不要全量读取：

- 所有书籍原文。
- 所有 PDF 全文。
- 所有 OCR 图片页。
- 所有客户案例原文。
- 六组未来所有角色私有知识。

总控按当前阶段加载最小必要知识，避免把资料堆成上下文污染。

## 记忆使用规则

1. 先确认企业知识库基座当前状态，再决定是否进入下一阶段。
2. 先看来源和脱敏，再看知识条目质量。
3. 四库字段冲突时，总控定义主库和关联库。
4. 方法经验只进入 `reusable_method`、`answer_structure`、`application_scenarios`、`recommended_usage` 或组织实践标签。
5. 每个分发包必须写清楚六组使用场景和回流要求。
6. 红线失败时输出返工角色，不输出假完整结论。
