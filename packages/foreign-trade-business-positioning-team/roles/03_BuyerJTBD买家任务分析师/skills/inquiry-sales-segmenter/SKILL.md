---
name: inquiry-sales-segmenter
description: "分析最近 30-90 天询盘文本、报价状态和成交记录，识别真实买家类型、采购任务、有效询盘率、成交潜力和买家错配。"
---

# Inquiry Sales Segmenter

## 使用场景

当用户提供询盘截图、聊天记录、询盘导出表、报价记录、成交状态、流失原因或业务员跟进表时使用。

本 Skill 用于校准真实买家，不用公开店铺语义代替真实询盘。

## 必读知识

先读取：

- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/01_JTBD核心定义与禁忌.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/02_B2B多角色采购任务拆解.md`
- `knowledge/roles/03_BuyerJTBD买家任务分析师/06_输出模板与交接格式.md`

## 输入

可接受：

- 近 30-90 天询盘文本。
- 买家国家和身份。
- 采购量、MOQ、用途。
- 报价后是否成交。
- 成交产品和订单金额区间。
- 未成交原因。
- 复购客户标记。

## 流程

1. 脱敏处理：删除姓名、邮箱、电话、WhatsApp、公司全称。
2. 按买家国家、身份、用途、采购量、价格敏感度分组。
3. 识别有效询盘、低质询盘、项目型询盘、品牌型询盘、批发型询盘。
4. 提取真实采购任务：买家到底要完成什么项目、补什么货、解决什么风险。
5. 识别成交和未成交分界：价格、交期、认证、信任、MOQ、响应速度。
6. 给出推荐优先买家和错配预警。
7. 将结论交给 BuyerJTBD 主分析，不直接写最终定位。

## 输出

必须输出：

```yaml
inquiry_buyer_segments:
  period:
  total_inquiries:
  valid_inquiry_rate:
  source_type: "export | screenshot | manual_table | interview"
  segments:
    - buyer_type:
      country:
      main_need:
      purchase_volume:
      use_case:
      anxiety:
      quoted:
      deal_status:
      deal_potential:
      sample_evidence:
  recommended_priority_buyer:
  mismatch_warning:
  data_gaps:
  handoff_to_buyer_jtbd:
```

## 质量门

可以支撑 `discussion_ready`：

- 有 10 条以上脱敏询盘样本。
- 能看出买家国家、用途和采购量。

可以支撑 `decision_ready`：

- 有 30 条以上询盘样本。
- 有成交 / 未成交状态。
- 能关联到产品、国家和买家类型。

只能输出 `hypothesis_only`：

- 只有公开店铺页面。
- 没有真实询盘文本。
- 只有业务员口述“感觉客户是某类人”。

## 边界

不要输出：

- 页面文案。
- 7 屏 brief。
- 最终经营定位。

可以输出：

- 买家分层。
- 真实采购任务。
- 买家错配。
- 下一步补问清单。

