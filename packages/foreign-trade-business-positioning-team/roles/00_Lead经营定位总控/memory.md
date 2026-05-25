# Memory：Lead 经营定位总控知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/01_能力问题与质量门.md` | 能力问题、红线和验收标准 |
| `knowledge/shared/03_方法路由卡.md` | Team 调用顺序和返工规则 |
| `knowledge/shared/04_报告输出模板.md` | 最终报告结构 |
| `knowledge/shared/05_经营罗盘指标映射.md` | 指标影响汇总 |
| `knowledge/shared/06_客户版表达与去黑话规则.md` | 客户版优先、去黑话和内部附录边界 |
| `handoff_contract.yaml` | 角色交接契约 |
| `quality_gates.md` | Team 总质量门 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/00_Lead经营定位总控/01_总控调度状态机.md` | Team 调度状态机 |
| `knowledge/roles/00_Lead经营定位总控/02_交接门与返工规则.md` | 交接门、返工路由和红线 |
| `knowledge/roles/00_Lead经营定位总控/03_路径仲裁规则.md` | 路径冲突仲裁 |
| `knowledge/roles/00_Lead经营定位总控/04_最终报告汇总规则.md` | 汇总原则和结论分级 |
| `knowledge/roles/00_Lead经营定位总控/05_证据等级与交付判定.md` | A/B/C/D 证据等级和交付状态 |
| `knowledge/roles/00_Lead经营定位总控/06_输出模板与最终交付格式.md` | 标准输出 schema |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| 各角色 `roles/*/README.md` | 需要确认角色边界 |
| 各角色 `roles/*/user.md` | 需要确认输入输出协议 |
| 各角色 `knowledge_refs.yaml` | 需要确认知识挂载 |

## 不加载

默认不要全量读取：

- 所有书籍原文。
- 所有案例全文。
- 所有 Worker 私有知识正文。

Lead 按状态机调用当前需要的输出和规则，不把整个知识库塞进上下文。

## 记忆使用规则

1. 先读 MetricQualityGate，再决定最终状态。
2. 红线失败时不汇总最终交付版报告。
3. 只汇总通过交接门的角色输出。
4. 每个关键结论必须标注证据等级。
5. 每个返工建议必须指定退回角色。
6. 默认先出客户版摘要和客户版报告；证据等级、状态码、角色编号和红线细节只进内部附录。
