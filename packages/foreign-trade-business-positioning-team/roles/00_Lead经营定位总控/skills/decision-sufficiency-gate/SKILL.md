---
name: decision-sufficiency-gate
description: "在核心经营结论前检查证据是否足够，判断输出是 decision_ready、discussion_ready、hypothesis_only 还是 blocked，并给出缺失证据和允许输出边界。"
---

# Decision Sufficiency Gate

## 使用场景

当 Team 准备下任何核心经营判断时使用，包括：

- 最应该做哪盘生意。
- 第一优先买家是谁。
- 哪个产品应该主推。
- 哪些优势能放进定位。
- 页面首屏怎么改。
- 报告是否允许交付。

本 Skill 是 Lead 的硬门。它不负责写新结论，只负责判断结论能不能成立。

## 必读知识

先读取：

- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/shared/03_方法路由卡.md`
- `knowledge/roles/00_Lead经营定位总控/05_证据等级与交付判定.md`
- `knowledge/roles/00_Lead经营定位总控/04_最终报告汇总规则.md`

## 输入

必须尽量读取：

```yaml
client_profile_yaml:
store_performance_snapshot:
inquiry_buyer_segments:
sku_performance_map:
market_competitor_scan:
supply_mapping_analysis:
metric_quality_gate:
```

## 流程

1. 明确当前要判断的 `decision`。
2. 识别证据来源：后台、询盘、销售、SKU、页面、竞品、访谈、推断。
3. 按 `07_经营数据证据门.md` 给证据评级。
4. 判断输出等级：
   - `decision_ready`
   - `discussion_ready`
   - `hypothesis_only`
   - `blocked`
5. 明确允许写什么、禁止写什么。
6. 如果不足，输出缺失证据和下一步补数请求。
7. 把内部等级翻译成客户能看懂的话。

## 输出

必须输出：

```yaml
decision_sufficiency_gate:
  decision:
  output_level: "decision_ready | discussion_ready | hypothesis_only | blocked"
  data_maturity_grade: "D0 | D1 | D2 | D3 | D4"
  evidence_used:
    store_backend:
    inquiry_data:
    sales_data:
    sku_data:
    page_assets:
    competitor_public_data:
    customer_interview:
    inferred:
  missing_evidence:
  allowed_output:
  forbidden_output:
  next_data_request:
  customer_facing_explanation:
```

## 质量门

必须输出 `blocked`：

- 缺主营产品。
- 缺目标买家。
- 缺增长目标。
- 只有空泛口述，且用户要求最终决策报告。

必须输出 `hypothesis_only`：

- 只有公开店铺和竞品资料。
- 没有后台、询盘、订单任一类数据。

最高只能输出 `discussion_ready`：

- 有后台数据但无询盘 / 成交。
- 有询盘但无成交 / 毛利。
- 有成交但无法关联产品和买家类型。

可以输出 `decision_ready`：

- 有后台、询盘、订单或 SKU 至少三类数据。
- 核心结论能回到明确证据。
- 客户版能说清楚为什么这么判断。

## 边界

不要输出：

- 新定位语。
- 新买家 Job。
- 新页面文案。

可以输出：

- 允许交付等级。
- 返工角色。
- 缺失证据。
- 客户版风险说明。

