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

- `inputs/` 放客户输入、截图、表格、链接清单和脱敏说明。
- `roles/` 放各角色中间产物，按角色编号分目录。
- `final/` 放客户可读最终报告、页面 brief、定位结论和交付版文档。
- `qa/` 放质量门、证据门、返工记录和内部审查。
- `samples/` 只放可公开、已脱敏、可教学的样例。

不要把客户隐私、未脱敏后台数据、订单明细或联系人信息提交到 GitHub。
