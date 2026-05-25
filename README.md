# Accio Agent Teams

本仓库用于发布可安装的 Accio Team 包。

仓库地址：

```text
https://github.com/chenye1313/accio-agent-teams
```

## 发给别人怎么说

如果你要让别人帮你安装，不要只发一句口头描述。直接复制下面这段给对方：

```text
请打开这个 GitHub 仓库：
https://github.com/chenye1313/accio-agent-teams

先选择要安装哪个 Team：
A = 企业知识资产中心Team（知识库）
B = 外贸经营定位专家Team（经营定位）

如果你是 Windows 电脑，请在 cmd.exe 里复制对应 Team 的 Windows CMD 命令。
如果你是 Mac 电脑，请在 Terminal 里复制对应 Team 的 macOS / Linux 命令。

不要把中文说明粘进命令行，只复制代码块里的命令。
```

当前包含两个 Team：

| Team key | Team 名称 | 说明 |
|---|---|---|
| `enterprise-knowledge-assets-team` | 企业知识资产中心Team | 企业资料接收、脱敏、四库构建、质量分发和回流 Team |
| `foreign-trade-business-positioning-team` | 外贸经营定位专家Team | 经营数据驱动的外贸经营定位、页面表达和指标复盘 Team |

## 一键安装

Mac 和 Windows 必须分开，因为两边的终端、引号和脚本执行方式不同。不要把 Mac 命令拿到 Windows 执行，也不要把 Windows 命令拿到 Mac 执行。

完整安装说明见 [安装说明](INSTALL.md)。

两个 Team 是单独安装的。只要知识库就只装 A；只要经营定位就只装 B；两个都要就按自己的系统分别执行 A 和 B 两条命令。

经营定位 Team 安装到 Accio 后，Agent 卡片名称会使用纯中文角色名，例如 `经营定位总控`、`资料采集官`、`生意模式分析师`，不会显示内部文件夹里的英文前缀。

安装器会做三件事：

1. 把 Team 包安装到本机 `.accio/agent-ready/Teams/`。
2. 在 `.accio/accounts/<account-id>/agents/` 下创建每个角色对应的 Accio Agent。
3. 把每个角色的 `skills/*/SKILL.md` 安装到对应 Agent 的 `agent-core/skills/`，并生成 `skills.jsonc`。

默认模型会写成 Accio 的 `DeepSeek V4 Pro`，不是 `auto`。安装日志会显示 `Default model: DeepSeek V4 Pro (...)`。

安装前请先打开过 Accio 并完成登录，让本机存在 `.accio/accounts/<account-id>/`。安装后如 Accio 已经开着，建议重启或刷新 Accio。

### A. 企业知识资产中心Team（知识库）

macOS / Linux：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team enterprise-knowledge-assets-team
```

Windows CMD：

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'enterprise-knowledge-assets-team'"
```

### B. 外贸经营定位专家Team（经营定位）

macOS / Linux：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team foreign-trade-business-positioning-team
```

Windows CMD：

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'foreign-trade-business-positioning-team'"
```

## 默认安装位置

macOS / Linux：

```text
~/.accio/agent-ready/Teams/<TeamName>
~/.accio/accounts/<account-id>/agents/MID-AT-.../
```

Windows：

```text
%USERPROFILE%\.accio\agent-ready\Teams\<team-key>
%USERPROFILE%\.accio\accounts\<account-id>\agents\MID-AT-...
```

Windows 默认使用英文 `team-key` 作为文件夹名，避免 PowerShell 5.1 在中文路径上出现乱码。

如果本机有多个非 guest Accio 账号，安装器默认会安装到所有非 guest 账号，避免装完后当前登录账号看不到。需要限定账号时使用 `--account-id` / `-AccountId`。

也可以指定目标目录：

macOS / Linux：

```bash
bash install/mac.sh --team foreign-trade-business-positioning-team --accio-agent-ready-root "/path/to/.accio/agent-ready"
```

Windows：

```powershell
.\install\win.ps1 -Team foreign-trade-business-positioning-team -AccioAgentReadyRoot "C:\path\to\.accio\agent-ready"
```

如果在 `cmd.exe` 里执行，不要使用中文引号、弯引号或省略 `https://`。命令必须保留完整 URL。

## Windows 装完找不到怎么办

安装完成后，Windows 终端会打印这些关键行：

```text
Accio home: ...
Accio accounts found: ...
Target Accio accounts: ...
Agent profile root: ...
Team conversation: ...
Registered Accio agents: ...
Default model: DeepSeek V4 Pro (...)
```

如果 Accio UI 里找不到 Agent，优先检查：

1. 是否先打开过 Accio 并登录，不是只安装过软件。
2. `Target Accio accounts` 里是否包含当前登录账号；多账号电脑最容易装到另一个账号。
3. `Registered Accio agents` 是否大于 0。
4. 是否重启或刷新过 Accio。
5. 公司网络是否拦截 GitHub 下载；如果下载失败，终端会停在 `Invoke-WebRequest` 或 `tar.exe` 附近。

## Windows 离线文件夹安装

如果客户电脑一直无法通过 GitHub 命令安装，就不要继续折腾网络路径。把本仓库整个文件夹发给客户，让客户解压后运行根目录的脚本：

```text
B_install_positioning_team.cmd    安装外贸经营定位专家Team
A_install_knowledge_team.cmd      安装企业知识资产中心Team
INSTALL_all_teams.cmd             两个 Team 都安装
CHECK_installed_teams.cmd         检查是否写入成功
```

离线安装不访问 GitHub，会直接读取当前文件夹里的 `packages/`。详细说明见 [Windows 离线文件夹安装](WINDOWS_OFFLINE_README.md)。

## Output 产物约定

每个 Team 都带有 `output/README.md`。运行产物统一写入：

```text
output/runs/<YYYYMMDD-HHMMSS_client-slug>/
```

不要把客户隐私、未脱敏后台数据、订单明细、联系人信息或未授权原始材料提交到 GitHub。

## 发布边界

本仓库只应放可交付包：

- `packages/<team-key>/roles/`
- `packages/<team-key>/knowledge/`
- `packages/<team-key>/output/README.md`
- Team README、workflow、manifest、质量门和安装脚本

不要放：

- 上层 `knowledge-base/`
- 上层 `process/`
- 原始书籍、PDF、OCR 原文
- 客户真实后台数据
- `.env`、token、账号、OAuth 或本机会话记录
