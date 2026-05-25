# 05 Differentiation 差异化定位师：私有知识切片

本目录用于放置 Differentiation 角色的可交付私有知识。它负责把 BusinessModel、BuyerJTBD、SupplyMapping 的结果压缩成有取舍、可落首屏的经营定位。

## 文件

| 文件 | 用途 |
|---|---|
| `01_定位输入门槛与取舍原则.md` | 定义定位进入门槛、四件套和取舍规则 |
| `02_特劳特心智抢词规则.md` | 成熟品类下的心智词、竞争对比和抢词规则 |
| `03_华与华信任前置规则.md` | 顾问式 B2B 供应链的信任前置路径 |
| `04_路径选择决策树.md` | 仲裁 mind_word / trust_first / hybrid |
| `05_禁用话术与竞争对比.md` | 禁用泛化话术，输出不服务对象 |
| `06_输出模板与案例样例.md` | 输出标准 YAML 和两个案例样例 |

## 源引用

`roles/05_Differentiation差异化定位师/knowledge_refs.yaml`

## 角色边界

- Differentiation 负责定位取舍，不负责页面排版和 7 屏内容。
- 只能使用 SupplyMapping 通过的强能力和可信证据。
- 必须输出 `forbidden_claims` 和 `not_for`。
