---
description: 一屏总览库状态：进行中项目、稿件状态分布、停滞提醒、Inbox 积压
argument-hint: [项目名（只看单项目，可留空）]
---
目标：$ARGUMENTS（留空 = 全库总览）

步骤（全程只读）：
1. 执行确定性脚本取数（**不要自行统计，避免数错**）：
   `bash 00-System/scripts/status.sh [项目名]`
2. 基于脚本输出给 1–3 条行动建议，例如：
   - 有 revising 稿 → "建议先跑 /produce/iterate 处理人工修改稿"
   - Inbox 积压 > 5 → "建议做每周清理（使用指南 §4.3）"
   - 项目 brief 超两周未更新 → "建议跑 /produce/brief 更新进展快照"
3. 只读：不修改、不新建任何文件。
