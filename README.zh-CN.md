<div align="center">

# 育婴宝 (YuyingBao)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)

[English](./README.md) | 中文

基于 Flutter 的本地优先婴儿护理记录应用 —— 无云端、无账号，数据完全掌控在自己手中。

</div>

---

## 截图

> 即将上线

---

## 功能特性

- **多宝宝管理** — 在一个应用内管理多个宝宝的档案
- **8 种记录类型** — 母乳、瓶喂、配方奶、辅食、大便、成长、喝水、营养
- **今日概览** — 每日汇总一览无余
- **快速记录** — 常用操作一键完成
- **数据统计** — 喂养与成长趋势的柱状图和折线图
- **WHO 生长曲线** — 0–24 个月，P3 / P15 / P50 / P85 / P97 百分位线
- **知识库** — 按月龄分类的育儿知识文章
- **数据导入 / 导出** — 完整 JSON 备份与恢复
- **100% 本地存储** — 无云端、无账号，数据不离开设备
- **跨平台** — 支持 iOS 与 Android

---

## 技术栈

| 层级 | 技术 |
|---|---|
| UI 框架 | Flutter |
| 状态管理 | Riverpod + flutter_hooks |
| 本地数据库 | drift (SQLite) |
| 路由导航 | go_router |
| 图表 | fl_chart |
| 主题 | flex_color_scheme |

---

## 快速开始

### 环境要求

- Flutter SDK 3.x（[安装指南](https://docs.flutter.dev/get-started/install)）
- Dart SDK（随 Flutter 一同安装）

### 安装与运行

```bash
git clone https://github.com/yideng-xl/yuyingbao-app.git
cd yuyingbao-app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 架构设计

```
UI 层（Flutter Widgets）
        ↓
状态管理层（Riverpod Providers）
        ↓
服务层（业务逻辑）
        ↓
仓储层（抽象接口）
        ↓
数据层（drift/SQLite + JSON 资源文件）
```

---

## 数据格式

记录以 JSON 格式导出，示例如下：

```json
{
  "exportedAt": "2025-01-01T00:00:00Z",
  "babies": [
    {
      "id": "uuid",
      "name": "宝宝",
      "birthday": "2024-06-01"
    }
  ],
  "records": [
    {
      "id": "uuid",
      "babyId": "uuid",
      "type": "breastfeeding",
      "startTime": "2025-01-01T08:00:00Z",
      "durationMinutes": 15,
      "note": ""
    }
  ]
}
```

---

## 开发路线图

- [x] 8 种记录类型与快速录入
- [x] 今日概览看板
- [x] 图表数据统计
- [x] WHO 生长曲线（0–24 个月）
- [x] 按月龄分类的知识库
- [x] 多宝宝支持
- [ ] 数据导入 / 导出（文件选择器）
- [ ] 喂奶间隔提醒通知
- [ ] 生长数据叠加在 WHO 曲线图上
- [ ] 深色模式
- [ ] 云端同步（可选）
- [ ] 家庭共享

---

## 开源协议

MIT © [yideng-xl](https://github.com/yideng-xl)
