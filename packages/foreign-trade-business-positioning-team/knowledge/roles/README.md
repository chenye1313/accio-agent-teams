# Role Private Knowledge

这里放每个 Agent 的私有知识切片。

每个角色一个目录：

```text
00_Lead经营定位总控/
01_Intake资料采集官/
02_BusinessModel生意模式分析师/
03_BuyerJTBD买家任务分析师/
04_SupplyMapping供给能力映射师/
05_Differentiation差异化定位师/
06_Expression表达落地师/
07_MetricQualityGate经营罗盘质检官/
```

角色自己的 `knowledge_refs.yaml` 位于：

```text
roles/<role_id>/knowledge_refs.yaml
```

当前阶段先建立挂载清单；正式外发前再导出可外发知识正文。
