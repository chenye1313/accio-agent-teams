# Package Architecture：外贸经营定位专家 Team

版本：v0.2

日期：2026-05-23

## 交付定位

`agent-ready/Teams/外贸经营定位专家Team/` 是一个可传输、可审查、可平台装配的 Team 交付包。

上层 `knowledge-base/`、`process/`、`书籍/` 是内部源知识区，不应默认全量塞进客户交付包。

## 当前采用的结构

```text
外贸经营定位专家Team/
├── Team 协议文件
├── roles/                 # 每个 Agent 的身份、职责、知识引用
├── knowledge/             # 交付知识包
│   ├── shared/            # 全 Team 共享知识
│   ├── roles/             # 每个 Agent 私有知识切片
│   ├── cases/             # 脱敏案例与演示样例
│   └── raw_refs/          # 不外发原始材料的来源索引
├── knowledge_mount.yaml   # 机器可读挂载表
├── tests/                 # 回放验收与数据化升级测试
└── delivery_manifest.yaml # 交付清单与边界
```

## 源知识库与交付知识包的关系

| 类型 | 位置 | 说明 |
|---|---|---|
| 源知识库 | `knowledge-base/` | 长期维护、可复用、跨 Team 共享 |
| 过程证据 | `process/` | 深读、OCR、案例拆解、复盘记录 |
| 原始书籍 | `书籍/` | 内部使用，默认不进入交付包 |
| Team 交付知识 | `agent-ready/Teams/外贸经营定位专家Team/knowledge/` | 可随 Team 复制 / 上传 |
| 单角色知识引用 | `roles/<role>/knowledge_refs.yaml` | 告诉平台和人工该 Agent 拥有什么知识 |

## 为什么 Team 包内仍要有 `knowledge/`

因为后续你要把整个 Team 交给别人，别人不应该还依赖你的 Obsidian 全库路径。

Team 包必须能回答：

1. 这个 Team 需要哪些共享知识？
2. 每个 Agent 私有读哪些知识？
3. 哪些材料可以交付？
4. 哪些材料只是内部来源，不外发？
5. 如果平台只支持一个知识库，应该上传哪个目录？
6. 如果平台支持角色级知识库，每个 Agent 应该挂哪个目录？
7. 数据化经营分析需要哪些输入、证据门和回放验收？

## 当前最小可交付策略

当前先不复制全部知识正文进 `knowledge/`，先建立交付架构和引用清单。

原因：

1. 源材料里有书籍、PDF、过程文件，不适合直接外发。
2. 现阶段还没有确认 Accio 平台知识库上传限制。
3. 先用 `knowledge_mount.yaml` 和 `knowledge_refs.yaml` 管住边界，再做导出脚本更稳。

下一步如果要真正打包外发，再生成：

```text
knowledge/shared/*.md
knowledge/roles/<role_id>/*.md
knowledge/cases/*.md
tests/*.md
knowledge/raw_refs/source_manifest.yaml
```

## 平台上传策略

### 单知识库平台

上传：

```text
knowledge/
```

并在每个 Agent Prompt 里写：

```text
只读取你的 roles/<role>/knowledge_refs.yaml 中声明的知识切片。
```

### 多知识库平台

上传：

```text
knowledge/shared/         -> Team 共享知识库
knowledge/roles/<role>/   -> 单角色私有知识库
knowledge/cases/          -> 案例库，按需绑定
```

## 当前边界

当前 Team 包适合内部演示、培训交付准备、平台上传前彩排。

正式外发前必须再做一次：

1. 脱敏审查。
2. 版权审查。
3. 客户案例可公开性审查。
4. 平台上传实测。
5. 知识文件复制 / 导出脚本验证。
6. 数据脱敏审查，尤其是询盘、订单、毛利和客户联系人。
