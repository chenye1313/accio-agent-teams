# Output 产物目录

本目录只放运行产物，不放角色设定、知识库正文或安装脚本。

推荐结构：

```text
output/
├── samples/
└── runs/
    └── <YYYYMMDD-HHMMSS_client-slug>/
        ├── inputs/
        ├── roles/
        ├── final/
        ├── qa/
        └── run_manifest.yaml
```

约定：

- `inputs/` 放资料清单、来源索引、脱敏说明和授权边界。
- `roles/` 放各角色中间产物，按角色编号分目录。
- `final/` 放四库交付包、内容应用路由和最终交付说明。
- `qa/` 放证据等级、权限检查、AI-Slop 扫描和返工记录。
- `samples/` 只放可公开、已脱敏、可教学的样例。

不要把客户隐私、未脱敏原始资料、订单明细或联系人信息提交到 GitHub。
