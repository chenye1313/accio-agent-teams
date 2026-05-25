# Windows 离线文件夹安装

这个方式不依赖 GitHub，不下载，不解压网络包。把整个文件夹发给客户，对方解压后直接运行根目录里的 `.cmd` 文件。

## 客户操作

1. 先打开一次 Accio，并完成登录。
2. 完全退出 Accio。
3. 解压你发过去的整个文件夹。不要在压缩包里直接双击运行。
4. 双击对应脚本：

```text
B_install_positioning_team.cmd    安装外贸经营定位专家Team
A_install_knowledge_team.cmd      安装企业知识资产中心Team
INSTALL_all_teams.cmd             两个 Team 都安装
CHECK_installed_teams.cmd         检查是否写入成功
```

5. 安装结束后重新打开 Accio。

如果 Windows 提示文件来自互联网或 SmartScreen 拦截：

1. 右键 zip 文件，选择“属性”。
2. 如果底部有“解除锁定 / Unblock”，先勾选并确定。
3. 再重新解压运行。

## 如果客户说找不到

先让客户双击：

```text
CHECK_installed_teams.cmd
```

再让客户把根目录里的：

```text
install-log-*.txt
```

发回来。

关键看这些行：

```text
Accio accounts found:
Target Accio accounts:
Agent profile root:
Team conversation:
Registered Accio agents:
Default model:
```

如果 `Registered Accio agents` 大于 0，但 UI 看不到，通常是 Accio 没重启，或当前登录账号不是 `Target Accio accounts` 里的账号。
