# Memory：知识资产构建师知识加载表

## 必加载：上游与总控标准

| 文件 | 用途 |
|---|---|
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md` | 四库字段和归属规则 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md` | 交接门和返工路由 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/01_资料接收与托管师/04_资料完整度与四库路由规则.md` | 上游资料路由建议 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/01_资料接收与托管师/05_输出模板与交接格式.md` | 上游交接包格式 |

## 必加载：私有知识库

| 文件 | 用途 |
|---|---|
| `knowledge/roles/02_知识资产构建师/01_构建状态机.md` | 判断构建阶段和阻断条件 |
| `knowledge/roles/02_知识资产构建师/02_资料拆分覆盖清单.md` | 定义不同资料要拆出哪些信息 |
| `knowledge/roles/02_知识资产构建师/03_术语实体标准化规则.md` | 统一术语、实体、SKU、客户类型 |
| `knowledge/roles/02_知识资产构建师/04_企业与产品信息抽取规则.md` | 企业信息库和产品信息库抽取规则 |
| `knowledge/roles/02_知识资产构建师/05_客户问答与案例抽取规则.md` | 客户问答库和客户案例库抽取规则 |
| `knowledge/roles/02_知识资产构建师/06_组织实践标签与方法内沉规则.md` | 组织实践标签和方法内沉规则 |
| `knowledge/roles/02_知识资产构建师/07_输出模板与交接格式.md` | 标准输出和交接格式 |

## 必加载：前段 Accio 方法

| 文件 | 用途 |
|---|---|
| `前段ACCIO资料库分类整理/1、术语专项提取.md` | 术语专项提取 |
| `前段ACCIO资料库分类整理/2、案例专项提取.md` | 案例卡片化 |
| `前段ACCIO资料库分类整理/3、正文知识单元化.md` | 正文知识原子化 |
| `前段ACCIO资料库分类整理/4、FAQ 生成与整合.md` | FAQ 生成与整合 |
| `前段ACCIO资料库分类整理/优秀商业访谈师特质.md` | 组织实践萃取 |

## 必挂载：自建 Skills

| Skill | 用途 |
|---|---|
| `skills/term-entity-normalizer/SKILL.md` | 统一术语、实体、产品、客户和证据词 |
| `skills/enterprise-product-asset-extractor/SKILL.md` | 抽取企业信息和产品信息候选条目 |
| `skills/customer-qa-case-extractor/SKILL.md` | 抽取客户问答和客户案例候选条目 |
| `skills/organization-practice-tagger/SKILL.md` | 沉淀组织实践标签和方法内沉字段 |

## 不加载

默认不要全量读取：

- 未经资料接收与托管师处理的原始资料。
- 未脱敏聊天和合同。
- 与当前路由无关的所有资料。
- 六组业务交付文件。
