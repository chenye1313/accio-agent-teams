# 安装说明

仓库地址：

```text
https://github.com/chenye1313/accio-agent-teams
```

## 先判断电脑系统

- Windows：打开 `cmd.exe`，复制 Windows CMD 命令。
- Mac：打开 Terminal，复制 macOS / Linux 命令。

再判断要安装哪个 Team：

- A：企业知识资产中心Team（知识库）
- B：外贸经营定位专家Team（经营定位）

两个 Team 是单独安装的。只要知识库就只装 A；只要经营定位就只装 B；两个都要就按自己的系统分别执行 A 和 B 两条命令。

经营定位 Team 安装到 Accio 后，Agent 卡片名称会使用纯中文角色名，例如 `经营定位总控`、`资料采集官`、`生意模式分析师`，不会显示内部文件夹里的英文前缀。

不要把中文说明粘进命令行，只复制代码块里的命令。

## 安装器会安装什么

默认不是只下载文件夹，而是安装到 Accio 本机运行目录：

```text
.accio/agent-ready/Teams/<team>
.accio/accounts/<account-id>/agents/<agent-id>/profile.jsonc
.accio/accounts/<account-id>/agents/<agent-id>/agent-core/
.accio/accounts/<account-id>/agents/<agent-id>/agent-core/skills/
.accio/accounts/<account-id>/conversations/team/
```

默认模型会写成 Accio 的 `DeepSeek V4 Pro`：

```json
"model": {
  "provider": "accio",
  "name": "1Nova-bW7yT4kL9pN2",
  "displayName": "DeepSeek V4 Pro"
}
```

安装前需要先打开过 Accio 并完成登录，让本机已经有 `.accio/accounts/<account-id>/`。安装后如 Accio 已经开着，建议重启或刷新 Accio。

如果本机有多个非 guest Accio 账号，安装器默认会安装到所有非 guest 账号。需要指定账号时使用：

```text
--account-id <account-id>    # macOS / Linux
-AccountId <account-id>      # Windows PowerShell
```

## Windows CMD

### A. 企业知识资产中心Team（知识库）

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'enterprise-knowledge-assets-team'"
```

### B. 外贸经营定位专家Team（经营定位）

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'foreign-trade-business-positioning-team'"
```

Windows 默认安装到：

```text
%USERPROFILE%\.accio\agent-ready\Teams\<team-key>
%USERPROFILE%\.accio\accounts\<account-id>\agents\MID-AT-...
```

## macOS / Linux

### A. 企业知识资产中心Team（知识库）

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team enterprise-knowledge-assets-team
```

### B. 外贸经营定位专家Team（经营定位）

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team foreign-trade-business-positioning-team
```

macOS / Linux 默认安装到：

```text
~/.accio/agent-ready/Teams/<TeamName>
~/.accio/accounts/<account-id>/agents/MID-AT-.../
```

## 常见风险

- Accio 没登录过：没有 `.accio/accounts/<account-id>/`，安装器会提示先打开 Accio 登录。
- Accio 正在运行：文件已写入，但 UI 可能需要重启或刷新才显示新 Agent。
- Windows 解包：安装器默认下载 GitHub `main.tar.gz` 并用 `tar.exe` 解包，减少中文路径乱码；Windows 10 1803+ 通常自带 `tar.exe`。
- Windows PowerShell 5.1 编码：Windows 顶层 Team 文件夹默认用英文 `team-key`，脚本正文也避免中文提示，减少乱码和 ConstrainedLanguage 报错。
- 多账号：默认装到所有非 guest 账号；如果只想装一个账号，手动指定 account id。
- 重复安装：已有同名 Team 或 Agent 会先备份为 `.backup-YYYYMMDD-HHMMSS`，再写入新版本。

## Windows 装完找不到的检查顺序

安装日志里会打印：

```text
Accio home: ...
Accio accounts found: ...
Target Accio accounts: ...
Agent profile root: ...
Team conversation: ...
Registered Accio agents: ...
Default model: DeepSeek V4 Pro (...)
```

如果 UI 看不到：

1. 先重启 Accio。
2. 看 `Target Accio accounts` 是否是当前登录账号。
3. 看 `Registered Accio agents` 是否大于 0。
4. 打开 `Agent profile root` 对应目录，确认里面有 `MID-AT-.../profile.jsonc`。
5. 打开 `Team conversation` 对应文件，确认 Team 元数据已生成。
6. 如果报 `tar.exe not found`，说明 Windows 版本太老或环境被精简，需要升级系统或改用本地源码安装。

## Windows 离线文件夹安装

当 GitHub 在线安装在客户电脑上不稳定时，使用离线文件夹安装：

1. 把整个仓库文件夹发给客户。
2. 客户解压后，不要移动里面的 `packages` 和 `install` 文件夹。
3. 客户先打开 Accio 并登录一次，然后完全退出 Accio。
4. 双击根目录脚本：

```text
B_install_positioning_team.cmd    安装外贸经营定位专家Team
A_install_knowledge_team.cmd      安装企业知识资产中心Team
INSTALL_all_teams.cmd             两个 Team 都安装
CHECK_installed_teams.cmd         检查是否写入成功
```

离线安装脚本会调用：

```text
install/local-win.ps1
```

它会把 `SourceRoot` 固定为当前文件夹，不会访问 GitHub。

不要在 zip 压缩包里直接双击运行，必须先解压。如果 Windows 提示文件来自互联网，先右键 zip 文件，在属性里点 `Unblock / 解除锁定`，再解压。
