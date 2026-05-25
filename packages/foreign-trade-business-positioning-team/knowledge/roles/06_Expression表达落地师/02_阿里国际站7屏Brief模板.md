# 02 阿里国际站 7 屏 Brief 模板

版本：v0.1  
适用角色：`06_Expression表达落地师`

## 1. 7 屏结构

```yaml
seven_screen_brief:
  screen_1:
    name: "首屏定位"
    cost_reduced: "识别成本"
  screen_2:
    name: "产品 / 方案结构"
    cost_reduced: "理解成本"
  screen_3:
    name: "核心服务"
    cost_reduced: "决策成本"
  screen_4:
    name: "场景案例"
    cost_reduced: "信任成本"
  screen_5:
    name: "交付过程"
    cost_reduced: "履约焦虑"
  screen_6:
    name: "信任资产"
    cost_reduced: "信任成本"
  screen_7:
    name: "CTA"
    cost_reduced: "行动成本"
```

## 2. 每屏字段

```yaml
screen:
  objective: ""
  target_buyer_decision: ""
  headline: ""
  subcopy: ""
  content_blocks:
    - ""
  proof_assets:
    - ""
  visual_direction: ""
  cta: ""
  cost_reduced: ""
  risk_if_missing: ""
```

## 3. 首屏规则

首屏必须包含：

1. 目标买家。
2. 核心 Job 或经营结果。
3. 核心可信证据。
4. 明确 CTA。

不能只写：

```text
Professional manufacturer since 2007
```

除非目标买家只关心制造资历。

## 4. 7 屏质量门

| 屏 | 必须回答 |
|---|---|
| 首屏 | 我是谁，我帮谁，帮他完成什么 |
| 第二屏 | 产品/方案如何组织 |
| 第三屏 | 核心服务如何降低风险 |
| 第四屏 | 有哪些可代入的场景 |
| 第五屏 | 交付过程是否可信 |
| 第六屏 | 有哪些硬信任资产 |
| 第七屏 | 买家下一步做什么 |

## 5. 源证据锚点

- `knowledge-base/经营定位/04_经营定位报告模板.md`：第 8 节 7 屏 Brief 表。
- `process/cases/case1_sweethome_extract.md`：R2-R78 是成熟 7 屏表达样例。
- `knowledge-base/经营定位/05_外贸Agent资料补缺映射.md`：经营定位后应接经营指标、外贸 Skill 和场景解决方案。
