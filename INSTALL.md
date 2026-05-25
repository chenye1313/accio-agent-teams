# 安装说明

仓库地址：

```text
https://github.com/chenye1313/accio-agent-teams
```

## 先判断电脑系统

- Windows：打开 `cmd.exe`，复制 Windows CMD 命令。
- Mac：打开 Terminal，复制 macOS / Linux 命令。

不要把中文说明粘进命令行，只复制代码块里的命令。

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
```
