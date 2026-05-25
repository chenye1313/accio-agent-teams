---
name: intake-profile-builder
description: "把外贸企业的 Excel、店铺资料、公司介绍、产品目录、语音访谈或口述信息整理成经营定位 Team 可调用的 client_profile.yaml，并判断资料完整度。"
---

# Intake Profile Builder

## 使用场景

当用户提供外贸企业资料、品牌经营定位表、店铺链接、访谈记录、产品目录或口述信息，并希望进入经营定位专家 Team 分析时使用。

本 Skill 只负责资料采集、字段归一、完整度评分和追问，不负责输出最终经营定位。

## 必读知识

先读取：

- `knowledge/shared/02_输入字段与完整度.md`
- `knowledge/shared/07_经营数据证据门.md`
- `knowledge/roles/01_Intake资料采集官/01_字段归一规则.md`
- `knowledge/roles/01_Intake资料采集官/02_完整度评分与阻断规则.md`
- `knowledge/roles/01_Intake资料采集官/05_client_profile_yaml模板.md`

按需读取：

- `knowledge/roles/01_Intake资料采集官/03_现场调研表_可交付版.md`
- `knowledge/roles/01_Intake资料采集官/04_语音访谈脚本_可交付版.md`

## 输入

可接受：

- Excel 字段。
- 公司介绍。
- 店铺链接摘要。
- 产品目录。
- 语音转写。
- 客户口述。
- 阿里后台简表。
- 询盘样本。
- 成交 / SKU 简表。

## 流程

1. 识别资料来源。
2. 抽取候选字段。
3. 映射到最小 12 字段。
4. 生成 `client_profile.yaml` 草稿。
5. 如有后台、询盘、成交或 SKU 数据，提示调用 `store-performance-intake`。
6. 计算 `completeness_grade` 和 `data_maturity_grade`。
7. 判断是否 `pass_to_next_role`。
8. 如果资料不足，输出最多 7 个追问。

## 输出

必须输出：

```yaml
client_profile_yaml:
  brand_name:
  main_products:
  main_markets:
  growth_goal:
  current_business_model:
  target_buyer_types:
  priority_buyer:
  product_differentiation:
  customization_services:
  certifications:
  delivery_cycle:
  current_positioning:
  source_map:

intake_gate:
  completeness_grade:
  pass_to_next_role:
  blocking_fields:
  missing_fields:
  follow_up_questions:

store_performance_snapshot:
  path_or_inline:
  data_maturity_grade:
  missing_data_pack:
```

## 质量门

禁止进入下一角色：

- 缺目标买家。
- 缺第一优先买家。
- 缺产品或主营方向。
- 缺当前生意模式。
- 缺差异化或能力证据。
- 最小 12 字段缺 4 项以上。

允许假设版进入下一角色，但必须标注：

- 缺认证。
- 缺真实询盘。
- 缺店铺后台指标。
- 缺交付周期。
- 缺真实成交或 SKU 数据。

## 边界

不要输出：

- 经营定位一句话。
- 生意模式判断。
- 买家 JTBD 分析。
- 差异化定位。
- 阿里 7 屏 brief。
- 经营罗盘指标判断。

这些交给后续角色。
