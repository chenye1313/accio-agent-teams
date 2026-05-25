# 安装说明

仓库地址：

```text
https://github.com/chenye1313/accio-agent-teams
```

## 先判断电脑系统

- Windows：打开 `cmd.exe`，复制 Windows CMD 命令。
- Mac：打开 Terminal，复制 macOS / Linux 命令。

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

安装前需要先打开过 Accio 并完成登录，让本机已经有 `.accio/accounts/<account-id>/`。安装后如 Accio 已经开着，建议重启或刷新 Accio。

如果本机有多个非 guest Accio 账号，安装器默认会安装到所有非 guest 账号。需要指定账号时使用：

```text
--account-id <account-id>    # macOS / Linux
-AccountId <account-id>      # Windows PowerShell
```

## Windows CMD

安装外贸经营定位专家 Team：

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'foreign-trade-business-positioning-team'"
```

安装企业知识资产中心 Team：

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'enterprise-knowledge-assets-team'"
```

Windows 默认安装到：

```text
%USERPROFILE%\.accio\agent-ready\Teams\<team-key>
%USERPROFILE%\.accio\accounts\<account-id>\agents\MID-AT-...
```

## macOS / Linux

安装外贸经营定位专家 Team：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team foreign-trade-business-positioning-team
```

安装企业知识资产中心 Team：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team enterprise-knowledge-assets-team
```

macOS / Linux 默认安装到：

```text
~/.accio/agent-ready/Teams/<TeamName>
~/.accio/accounts/<account-id>/agents/MID-AT-.../
```

## 常见风险

- Accio 没登录过：没有 `.accio/accounts/<account-id>/`，安装器会提示先打开 Accio 登录。
- Accio 正在运行：文件已写入，但 UI 可能需要重启或刷新才显示新 Agent。
- Windows PowerShell 5.1 编码：Windows 顶层 Team 文件夹默认用英文 `team-key`，避免中文路径乱码。
- 多账号：默认装到所有非 guest 账号；如果只想装一个账号，手动指定 account id。
- 重复安装：已有同名 Team 或 Agent 会先备份为 `.backup-YYYYMMDD-HHMMSS`，再写入新版本。
