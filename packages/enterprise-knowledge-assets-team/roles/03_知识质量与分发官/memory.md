# Memory：知识质量与分发官知识加载表

## 必加载：上游和总控标准

| 文件 | 用途 |
|---|---|
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md` | 确认交接物、最低标准和返工路由 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md` | 来源、证据、隐私和公开权限红线 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/05_六组分发与回流规则.md` | 六组分发包和回流协议 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/02_知识资产构建师/07_输出模板与交接格式.md` | 上游构建师交接格式 |

## 必加载：私有知识库

| 文件 | 用途 |
|---|---|
| `knowledge/roles/03_知识质量与分发官/01_质量分发状态机.md` | 判断质检和分发阶段 |
| `knowledge/roles/03_知识质量与分发官/02_证据等级与来源一致性规则.md` | 来源一致性、证据等级和权限规则 |
| `knowledge/roles/03_知识质量与分发官/03_四库条目验收与AI-Slop扫描.md` | 四库验收、20 分制和 AI-Slop |
| `knowledge/roles/03_知识质量与分发官/04_六组分发包与调用契约.md` | 分发给六组的标准包 |
| `knowledge/roles/03_知识质量与分发官/05_回流记录与知识更新规则.md` | 回流记录、更新和返工 |
| `knowledge/roles/03_知识质量与分发官/06_输出模板与交接格式.md` | 标准输出和交接格式 |

## 必挂载：自建 Skills

| Skill | 用途 |
|---|---|
| `skills/evidence-source-quality-auditor/SKILL.md` | 检查来源、证据等级、权限和脱敏 |
| `skills/knowledge-ai-slop-scanner/SKILL.md` | 扫描泛泛表达、无证据结论和伪知识 |
| `skills/six-group-distribution-packager/SKILL.md` | 将通过质检的知识打包给六组 |
| `skills/feedback-loop-recorder/SKILL.md` | 记录六组回流并生成更新请求 |

## 20 分制

| 维度 | 分值 |
|---|---:|
| 准确性 | 0-5 |
| 完整性 | 0-5 |
| 可追溯 | 0-5 |
| 可调用 | 0-5 |

低于 16 分不能进入正式库。

## 不加载

默认不要全量读取：

- 未经构建师处理的原始资料。
- 未脱敏聊天和合同。
- 六组业务交付全文。

本角色只处理候选条目、质量门、分发包和回流记录。
