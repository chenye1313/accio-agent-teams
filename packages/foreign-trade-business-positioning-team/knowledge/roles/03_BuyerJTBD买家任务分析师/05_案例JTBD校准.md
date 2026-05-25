# 05 案例 JTBD 校准

版本：v0.1  
适用角色：`03_BuyerJTBD买家任务分析师`

## 1. 用途

本文件用 Sweet Home 与 HOTBLIZZARD 两个案例校准 Job 写法。

案例只做参照，不做通用模板。

## 2. 案例 1：Sweet Home

来源：`process/cases/case1_sweethome_extract.md`

### 2.1 输入证据

- 商用客户、个人住宅、线下零售商、电商客户，重点关注商用客户：R2-R3。
- 凉亭为主，配套户外家具、橱柜、WPC 地板、围栏：R4。
- 一站式方案、CAD/3D 渲染、安装图纸、本地化服务中心、配件保障：R7。
- 信任资产包括品牌墙、好评、交付过程、本地化代理：R8。

### 2.2 合格 Job

```yaml
priority_buyer: "酒店 / 商业工程客户 / 承包商"
core_job: "在户外商业空间项目中，用更少协调成本和返工风险完成从设计、产品组合到安装支持的整体交付。"
struggling_moment: "项目客户需要把户外空间做成可用场景，但单独采购凉亭、家具、地板、安装和售后会造成协调成本和风险。"
current_workaround:
  - "分别找多个供应商采购单品"
  - "由承包商自行整合产品和安装"
  - "采购标准凉亭后再现场补配件和服务"
desired_outcomes:
  - "降低设计、生产、安装之间的沟通次数"
  - "降低项目超预算和返工概率"
  - "提高方案一次确认率"
  - "缩短售后配件响应周期"
purchase_anxiety:
  - "项目效果不符合业主预期"
  - "供应商无法支持本地安装和售后"
  - "多个产品组合后责任边界不清"
```

### 2.3 不合格 Job

```text
买家想采购凉亭。
```

问题：这是产品动作，不是项目客户的进步任务。

## 3. 案例 2：HOTBLIZZARD

来源：`process/cases/case2_hotblizzard_profile.yaml`

### 3.1 输入证据

- 优先买家：正在测试新品的街头潮牌创始人 / 小型潮流服饰品牌主。
- 阶段：起步、测款、扩张前期。
- 订单类型：小单测试、深度定制、量产补货。
- 能力：面料/图案/辅料工艺研发、快速打样、柔性量产、数据分析。
- 买家已知痛点：设计概念难以稳定转成可售样衣、小单测款与规模量产断层、供应链响应慢导致错过趋势窗口。

### 3.2 合格 Job

```yaml
priority_buyer: "正在测试新品的街头潮牌创始人 / 小型潮流服饰品牌主"
core_job: "在趋势窗口有限、库存风险高的情况下，用小单和快速打样把设计概念验证成可售新品，并在反馈有效后进入稳定补货。"
struggling_moment: "品牌主有设计想法或趋势机会，但不知道这款是否能卖，且担心首批库存、打样速度和量产衔接。"
current_workaround:
  - "找普通服装工厂做样衣，但缺少产品策略反馈"
  - "先大量下单赌爆款"
  - "用现货改标，牺牲品牌风格"
desired_outcomes:
  - "缩短从设计概念到可售样衣的周期"
  - "降低首批备货压错款的概率"
  - "提高小单测试反馈对量产决策的可信度"
  - "缩短趋势出现到商品上架的时间"
purchase_anxiety:
  - "供应商只能生产，不能帮助判断产品机会"
  - "小单供应商放量能力不足"
  - "定制细节不稳定影响品牌风格"
```

### 3.3 不合格 Job

```text
买家想采购卫衣、T 恤和潮流配饰。
```

问题：这是品类清单，不是潮牌主的采购任务。

## 4. 源证据锚点

- `process/cases/case1_sweethome_extract.md`：R2-R8。
- `process/cases/case2_hotblizzard_profile.yaml`：`priority_buyer`、`buyer_stage`、`main_order_type`、`buyer_pain_points_known`、`buyer_success_metrics_known`。
- `process/deep-review/book-indexes-json/B01.json`：B01 U703 提醒替代方案不局限于同品类竞争。
