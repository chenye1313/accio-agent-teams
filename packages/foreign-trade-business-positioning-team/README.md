# 外贸经营定位专家 Team

版本：v0.2

用途：把“经营定位专家”从单体 Agent 升级成可装配的 Team 包。新版目标不是只生成经营定位报告，而是用店铺后台、询盘、成交、SKU 和公开竞品资料，生成可解释、可追溯、可落地、可复盘的经营分析方案。

## Team 名称

中文名：外贸经营定位专家 Team

英文名：Foreign Trade Business Positioning Expert Team

## Team 定位

这不是品牌文案组，也不是全链路外贸运营自动化组。它负责一个数据化经营定位小闭环：

```text
客户输入
  -> 字段归一
  -> 经营数据诊断与决策证据门
  -> 生意模式判断
  -> 买家 JTBD
  -> 供给能力映射
  -> 差异化定位
  -> 7 屏表达
  -> 经营罗盘指标影响
  -> Lead 质检
  -> 经营定位报告
```

## 新版核心能力

1. 经营数据诊断：接入曝光、点击、访客、询盘、订单、SKU、关键词和国家数据。
2. 经营定位生成：判断做哪盘生意、服务谁、凭什么赢。
3. 页面改版落地：把定位转成阿里国际站 7 屏 brief、Slogan、信任资产和 CTA。
4. 经营指标复盘：绑定上线前基线和 7/30/90 天验证指标。
5. 决策证据门：区分可决策、可讨论、仅假设和禁止下结论。

## 角色目录

| 顺序 | 角色文件夹 | 负责模块 |
|---:|---|---|
| 00 | `roles/00_Lead经营定位总控/` | 总控、仲裁、质量门、最终报告 |
| 01 | `roles/01_Intake资料采集官/` | M00 输入采集与字段归一 |
| 02 | `roles/02_BusinessModel生意模式分析师/` | M01 生意模式判断 |
| 03 | `roles/03_BuyerJTBD买家任务分析师/` | M02 买家 JTBD 与成功指标 |
| 04 | `roles/04_SupplyMapping供给能力映射师/` | M03 供给能力映射 |
| 05 | `roles/05_Differentiation差异化定位师/` | M04 差异化定位 |
| 06 | `roles/06_Expression表达落地师/` | M05 7 屏表达与信任资产 |
| 07 | `roles/07_MetricQualityGate经营罗盘质检官/` | M06 指标影响 + M07 质量门 |

## 核心文件

- `TEAM.md`：Team 总控协议。
- `ACCIO部署交接说明.md`：给 ACCIO 部署同学的更新说明、部署清单和验收方式。
- `package_architecture.md`：当前 Team 的交付包结构说明。
- `delivery_manifest.yaml`：交付包机器清单与外发边界。
- `workflow.md`：运行流程与返工机制。
- `handoff_contract.yaml`：角色之间的交接契约。
- `shared_knowledge.md`：共享知识库加载表。
- `knowledge_load_plan.md`：共享知识库与角色私有知识切片的装配说明。
- `knowledge_mount.yaml`：机器可读知识库挂载表。
- `knowledge/`：可随 Team 复制 / 上传的交付知识包骨架。
- `quality_gates.md`：红线和验收。
- `platform_upload_pack.md`：平台粘贴 / 上传版。
- `商家上手说明.md`：给完全不会用的商家的使用说明和模拟场景。
- `经营分析有效性审计与Skill升级建议.md`：判断这套 Team 是否足够支撑真实经营分析，以及下一轮 Skill 升级方向。

## 知识库装配结论

不是 8 个 Agent 全部无差别共享一个大知识库。

本 Team 使用：

```text
K0 Team 共享底座
  + K1 角色私有知识切片
  + K2 案例记忆
  + K3 深读原始材料按需追溯
```

如果平台只支持绑定一个 Team 知识库，就把 `knowledge_load_plan.md` 列出的材料放到同一知识库中，但每个角色仍按 `knowledge_mount.yaml` 的 `must_load` 和 `on_demand` 读取。

## 交付包规划

源知识库仍在上层：

```text
knowledge-base/
process/
书籍/
```

交付给别人时，以本 Team 文件夹为单位：

```text
agent-ready/Teams/外贸经营定位专家Team/
```

其中 `knowledge/` 是交付知识包，`roles/*/knowledge_refs.yaml` 是每个 Agent 的私有知识引用。正式外发前，再把可外发、已脱敏、无版权风险的知识正文导出到 `knowledge/` 目录。

## 当前可运行样例

Case 2：HOTBLIZZARD。

输出：

- `output/经营定位专家小闭环/case2_client_profile.yaml`
- `output/经营定位专家小闭环/case2_business_positioning_report.md`
- `output/经营定位专家小闭环/case2_run_trace.md`
- `tests/case2_hotblizzard_replay.md`

数据化升级回放：

- `tests/sweethome_data_upgrade_replay.md`

## Output 产物目录

所有新运行产物统一写入本 Team 的 `output/` 目录，避免混在 `roles/`、`knowledge/` 或安装文件中。

推荐结构：

```text
output/
├── README.md
├── samples/                         # 脱敏样例
└── runs/
    └── <YYYYMMDD-HHMMSS_client-slug>/
        ├── inputs/                  # 客户输入、截图、表格、链接清单
        ├── roles/                   # 各角色中间产物
        │   ├── 01_intake/
        │   ├── 02_business_model/
        │   ├── 03_buyer_jtbd/
        │   ├── 04_supply_mapping/
        │   ├── 05_differentiation/
        │   ├── 06_expression/
        │   └── 07_metric_quality/
        ├── final/                   # 客户版最终报告与页面 brief
        ├── qa/                      # 质量门、证据门、返工记录
        └── run_manifest.yaml        # 本次运行索引
```

角色产物建议：

| 角色 | 推荐 output 子目录 | 典型产物 |
|---|---|---|
| `01_Intake资料采集官` | `roles/01_intake/` | `client_profile.yaml`、`store_performance_snapshot.yaml`、`missing_data_pack.md` |
| `02_BusinessModel生意模式分析师` | `roles/02_business_model/` | `business_model.yaml`、`sku_performance_map.yaml` |
| `03_BuyerJTBD买家任务分析师` | `roles/03_buyer_jtbd/` | `buyer_jtbd.yaml`、`inquiry_sales_segments.yaml` |
| `04_SupplyMapping供给能力映射师` | `roles/04_supply_mapping/` | `supply_mapping.yaml`、`market_competitor_scan.md` |
| `05_Differentiation差异化定位师` | `roles/05_differentiation/` | `positioning.yaml`、`forbidden_claims.md` |
| `06_Expression表达落地师` | `roles/06_expression/` | `seven_screen_brief.md`、`slogan_options.md` |
| `07_MetricQualityGate经营罗盘质检官` | `roles/07_metric_quality/` | `metric_impact_table.yaml`、`quality_gate.yaml` |
| `00_Lead经营定位总控` | `final/` 和 `qa/` | `business_positioning_report.md`、`run_trace.md`、`lead_quality_gate.yaml` |

## 边界

可以用于演示和内部彩排。正式客户交付前，必须补充真实询盘、店铺后台数据、可公开案例素材和平台实测记录。只有公开店铺链接时，输出必须降级为假设版；不能把假设版包装成经营决策报告。
