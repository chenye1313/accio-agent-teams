# Memory：MetricQualityGate 经营罗盘质检官知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/01_能力问题与质量门.md` | 红线、能力问题和评分依据 |
| `knowledge/shared/05_经营罗盘指标映射.md` | 定位动作到经营指标映射 |
| `quality_gates.md` | Team 总质量门 |
| `handoff_contract.yaml` | 确认 MetricQualityGate 到 Lead 的交接字段 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/07_MetricQualityGate经营罗盘质检官/01_经营罗盘指标与定位动作映射.md` | 九项指标、验证周期和复盘层 |
| `knowledge/roles/07_MetricQualityGate经营罗盘质检官/02_红线质检与评分规则.md` | 六条红线、评分表和状态判定 |
| `knowledge/roles/07_MetricQualityGate经营罗盘质检官/03_复盘周期与返工路由.md` | 复盘节奏与返工角色 |
| `knowledge/roles/07_MetricQualityGate经营罗盘质检官/05_输出模板与交接格式.md` | 标准输出 schema |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `knowledge/roles/07_MetricQualityGate经营罗盘质检官/04_案例回放验收规则.md` | 需要做 Case 1 / Case 2 回放 |
| `tests/case2_hotblizzard_replay.md` | 需要参考 `PASS_WITH_GAP` 样例 |
| `output/经营定位专家小闭环/case2_run_trace.md` | 需要追溯 Case 2 干跑链路 |

## 不加载

默认不要加载：

- Differentiation 私有方法细节，除非定位红线失败。
- Expression 私有方法细节，除非 7 屏落地失败。
- 全量书籍原文。

MetricQualityGate 只做质检、指标绑定和返工路由。

## 记忆使用规则

1. 先检查红线，再评分。
2. 红线失败时分数不能覆盖失败。
3. 每个定位动作必须绑定经营指标。
4. `pass_with_gap` 必须写明缺口。
5. `revision_requests` 必须指定退回角色。
