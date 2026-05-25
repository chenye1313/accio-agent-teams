# Memory：资料接收与托管师知识加载表

## 必加载：总控标准

| 文件 | 用途 |
|---|---|
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/03_角色交接门与返工规则.md` | 确认上游和下游交接标准 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/04_证据隐私质量门.md` | 复用来源、脱敏、公开权限红线 |
| `agent-ready/Teams/企业知识资产中心Team/knowledge/roles/00_Lead知识资产总控/02_四库建设策略与字段门.md` | 判断资料可能进入哪个库 |

## 必加载：私有知识库

| 文件 | 用途 |
|---|---|
| `knowledge/roles/01_资料接收与托管师/01_资料接收状态机.md` | 判断资料入口阶段和阻断条件 |
| `knowledge/roles/01_资料接收与托管师/02_来源索引与编号规则.md` | 建立 `asset_id`、`source_id` 和来源索引 |
| `knowledge/roles/01_资料接收与托管师/03_脱敏与权限标注规则.md` | 检查敏感信息、权限和公开边界 |
| `knowledge/roles/01_资料接收与托管师/04_资料完整度与四库路由规则.md` | 判断资料完整度和四库路由建议 |
| `knowledge/roles/01_资料接收与托管师/05_输出模板与交接格式.md` | 标准输出和交接格式 |

## 必挂载：自建 Skills

| Skill | 用途 |
|---|---|
| `skills/source-intake-custodian/SKILL.md` | 接收资料、建立来源索引和资料清单 |
| `skills/privacy-anonymization-gate/SKILL.md` | 检查脱敏、权限和不可外发内容 |
| `skills/material-routing-indexer/SKILL.md` | 判断资料完整度并给出四库路由建议 |

## 资料类型

```yaml
source_type:
  document: "PPT/PDF/Word/官网/公司介绍/证书"
  product: "产品目录/SKU表/报价单/详情页/图片视频"
  audio: "老板访谈/客户会议录音/销售语音"
  chat: "询盘/WhatsApp/邮件/OKKI/客服记录"
  backend: "阿里后台/OKKI/成交数据/产品表现"
  manual: "人工补充/老板回忆/销售复盘"
```

## 权限标签

```yaml
permission_status:
  public: "可公开使用"
  anonymized: "脱敏后可使用"
  internal_only: "只能内部使用"
  unknown: "权限未知，禁止对外"
  restricted: "受限资料，不能下发给普通角色"
```

## 不加载

默认不要全量读取：

- 所有客户原始聊天全文。
- 所有合同和付款信息。
- 所有 PDF/OCR 全文。
- 六组业务分析文件。

本角色只需要建立资料索引、脱敏状态和路由建议。
