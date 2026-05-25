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

如果你是 Windows 电脑，请在 cmd.exe 里复制 README 的 Windows CMD 命令。
如果你是 Mac 电脑，请在 Terminal 里复制 README 的 macOS / Linux 命令。

不要把中文说明粘进命令行，只复制代码块里的命令。
```

当前包含两个 Team：

| Team key | Team 名称 | 说明 |
|---|---|---|
| `foreign-trade-business-positioning-team` | 外贸经营定位专家Team | 经营数据驱动的外贸经营定位、页面表达和指标复盘 Team |
| `enterprise-knowledge-assets-team` | 企业知识资产中心Team | 企业资料接收、脱敏、四库构建、质量分发和回流 Team |

## 一键安装

Mac 和 Windows 必须分开，因为两边的终端、引号和脚本执行方式不同。不要把 Mac 命令拿到 Windows 执行，也不要把 Windows 命令拿到 Mac 执行。

完整安装说明见 [安装说明](INSTALL.md)。

macOS / Linux：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/mac.sh)" -- --team foreign-trade-business-positioning-team
```

Windows CMD：

```bat
powershell -NoProfile -ExecutionPolicy Bypass -Command "$p=Join-Path $env:TEMP 'accio-agent-teams-win.ps1'; Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/chenye1313/accio-agent-teams/main/install/win.ps1' -OutFile $p; & $p -Team 'foreign-trade-business-positioning-team'"
```

安装企业知识资产中心 Team 时，把 team key 换成：

```text
enterprise-knowledge-assets-team
```

## 默认安装位置

macOS / Linux：

```text
~/.accio/agent-ready/Teams/<TeamName>
```

Windows：

```text
%USERPROFILE%\.accio\agent-ready\Teams\<team-key>
```

Windows 默认使用英文 `team-key` 作为文件夹名，避免 PowerShell 5.1 在中文路径上出现乱码。

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
