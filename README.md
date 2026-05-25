# Accio Agent Teams

本仓库用于发布可安装的 Accio Team 包。

当前包含两个 Team：

| Team key | Team 名称 | 说明 |
|---|---|---|
| `foreign-trade-business-positioning-team` | 外贸经营定位专家Team | 经营数据驱动的外贸经营定位、页面表达和指标复盘 Team |
| `enterprise-knowledge-assets-team` | 企业知识资产中心Team | 企业资料接收、脱敏、四库构建、质量分发和回流 Team |

## 一键安装

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
%USERPROFILE%\.accio\agent-ready\Teams\<TeamName>
```

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
