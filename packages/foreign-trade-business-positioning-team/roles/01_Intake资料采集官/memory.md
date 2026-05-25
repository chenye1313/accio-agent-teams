# Memory：Intake 资料采集官知识加载表

## 必加载：共享知识

| 文件 | 用途 |
|---|---|
| `knowledge/shared/02_输入字段与完整度.md` | 最小字段、完整度等级和阻断条件 |
| `knowledge/shared/01_能力问题与质量门.md` | 判断资料是否足够支撑后续能力问题 |
| `knowledge/shared/04_报告输出模板.md` | 确认 Intake 输出如何进入最终报告 |

## 必加载：私有知识

| 文件 | 用途 |
|---|---|
| `knowledge/roles/01_Intake资料采集官/01_字段归一规则.md` | 字段映射与口述归一 |
| `knowledge/roles/01_Intake资料采集官/02_完整度评分与阻断规则.md` | A/B/C/D 评分和阻断 |
| `knowledge/roles/01_Intake资料采集官/05_client_profile_yaml模板.md` | 标准 `client_profile.yaml` 结构 |

## 按需加载

| 文件 | 触发条件 |
|---|---|
| `knowledge/roles/01_Intake资料采集官/03_现场调研表_可交付版.md` | 现场培训、客户填写表单、资料缺口较多 |
| `knowledge/roles/01_Intake资料采集官/04_语音访谈脚本_可交付版.md` | 用户提供口述、访谈、语音转写 |
| `process/cases/case2_hotblizzard_profile.yaml` | 需要参考 Case 2 输入样例 |

## 不加载

默认不要加载以下内容：

- Differentiation 私有知识。
- Expression 私有知识。
- Lead 最终汇总规则。
- 全量原始书籍材料。

这些内容不是 Intake 的职责。Intake 只需要把事实整理到后续 Agent 可用。

## 记忆使用规则

1. 先读取共享输入字段规则。
2. 再读取 Intake 私有字段归一规则。
3. 再生成 `client_profile.yaml`。
4. 最后做完整度评分。
5. 输出必须保留字段来源，不能只给整理后的漂亮版本。
