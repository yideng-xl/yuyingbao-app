<div align="center">

# 育婴宝 (YuyingBao)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-0.5.0-EC4899)](https://github.com/yideng-xl/yuyingbao-app/releases)

[English](./README.md) | 中文

基于 Flutter 的本地优先婴儿护理记录应用 — 无云端、无账号，数据完全掌控在自己手中。

</div>

---

## 截图

> 即将上线

---

## 功能特性

- **多宝宝管理** — 支持多个宝宝档案，任意页面一键切换
- **8 种记录类型** — 母乳亲喂、瓶喂、配方奶、辅食、尿布、成长记录、饮水、营养补充
- **今日概览** — 首页看板展示当日喂奶次数、总奶量、换尿布次数、饮水量
- **快速记录** — 常用操作一键录入，全屏表单方便填写
- **数据统计** — 喂养量柱状图、尿布趋势折线图
- **WHO 生长曲线** — 0-24 个月，P3 / P15 / P50 / P85 / P97 百分位线
- **育儿知识库** — 按月龄分类，支持搜索和筛选
- **4 套主题皮肤** — 温馨粉、清新蓝、自然绿、暖阳橙，设置页即时切换
- **Claymorphism 风格** — 柔和 3D、大圆角、轻柔阴影，温馨友好的视觉体验
- **100% 本地存储** — 无云端、无账号，数据不离开设备
- **跨平台** — 支持 iOS 与 Android

---

## 技术栈

| 层级 | 技术 |
|---|---|
| UI 框架 | Flutter 3.x |
| 状态管理 | Riverpod + flutter_hooks |
| 本地数据库 | drift (SQLite) |
| 路由导航 | go_router |
| 图表 | fl_chart |
| 主题 | flex_color_scheme |

---

## 主题皮肤

| 皮肤 | 主色 | 风格 |
|---|---|---|
| 温馨粉 | `#EC4899` | 甜蜜温馨，适合妈妈 |
| 清新蓝 | `#3B82F6` | 清爽沉稳，适合爸爸 |
| 自然绿 | `#10B981` | 清新自然，中性风格 |
| 暖阳橙 | `#F97316` | 活力满满，暖色调 |

---

## 快速开始

### 环境要求

- Flutter SDK 3.24+（[安装指南](https://docs.flutter.dev/get-started/install)）
- Xcode（iOS 开发）或 Android Studio（Android 开发）

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

- **Feature-first 组织** — 每个功能模块（首页、记录、统计、知识、设置）自包含
- **Repository 模式** — 抽象接口设计，为未来云同步预留扩展能力
- **响应式 UI** — 基于 `watchRecords()` Stream 实现数据实时更新

---

## 开发路线图

- [x] 8 种记录类型与快速录入
- [x] 今日概览看板
- [x] 图表数据统计
- [x] WHO 生长曲线（0-24 个月）
- [x] 按月龄分类的知识库
- [x] 多宝宝支持，任意页面切换
- [x] 4 套主题皮肤（Claymorphism 风格）
- [x] 全屏记录表单 + 删除确认
- [ ] 数据导入 / 导出（文件选择器）
- [ ] 喂奶间隔提醒通知
- [ ] 生长数据叠加在 WHO 曲线图上
- [ ] 深色模式
- [ ] 云端同步（可选）
- [ ] 家庭共享

---

## 开源协议

MIT © [yideng-xl](https://github.com/yideng-xl)
