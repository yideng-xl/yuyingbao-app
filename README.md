<div align="center">

# YuyingBao (育婴宝)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-0.6.0-EC4899)](https://github.com/yideng-xl/yuyingbao-app/releases)

[中文](./README.zh-CN.md) | English | [日本語](./README.ja.md) | [한국어](./README.ko.md)

A local-first baby care tracking app built with Flutter — no cloud, no account, just your data.

</div>

---

## Screenshots

> Coming soon

---

## Features

- **Multi-baby support** — manage profiles for multiple babies, switch instantly from any page
- **8 record types** — breastfeeding, bottle feeding, formula, solid food, diaper, growth, water, and nutrition
- **Today overview** — daily summary dashboard with feeding count, milk volume, diaper changes, and water intake
- **Quick record** — one-tap buttons for the most frequent actions, full-screen form for easy input
- **Statistics** — bar and line charts for feeding and growth trends
- **WHO growth curves** — 0-24 months, P3 / P15 / P50 / P85 / P97 percentile lines
- **Knowledge base** — age-appropriate baby care articles with Markdown rendering, search and age filter
- **4 theme skins** — Warm Pink, Ocean Blue, Nature Green, Sunny Orange — switch instantly in settings
- **Claymorphism UI** — soft 3D, rounded corners, gentle shadows for a warm and friendly feel
- **Multi-language** — Chinese, English, Japanese, Korean — switch in settings
- **Feeding reminders** — fixed-interval notifications so you never miss a feeding
- **Growth on WHO curves** — baby's full growth history plotted against WHO percentile lines
- **100% local** — no cloud, no account, no data leaves your device
- **Cross-platform** — iOS and Android

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter 3.x |
| State Management | Riverpod + flutter_hooks |
| Local Database | drift (SQLite) |
| Navigation | go_router |
| Charts | fl_chart |
| Markdown | flutter_markdown |
| Notifications | flutter_local_notifications |
| i18n | flutter_localizations + ARB |
| Theming | flex_color_scheme |

---

## Theme Skins

| Skin | Primary Color | Style |
|---|---|---|
| Warm Pink | `#EC4899` | Sweet, warm — perfect for moms |
| Ocean Blue | `#3B82F6` | Clean, calm — great for dads |
| Nature Green | `#10B981` | Fresh, natural — gender neutral |
| Sunny Orange | `#F97316` | Energetic, warm — cheerful vibe |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.24+ ([install guide](https://docs.flutter.dev/get-started/install))
- Xcode (for iOS) or Android Studio (for Android)

### Install & Run

```bash
git clone https://github.com/yideng-xl/yuyingbao-app.git
cd yuyingbao-app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Architecture

```
UI Layer (Flutter Widgets)
        ↓
State Management (Riverpod Providers)
        ↓
Service Layer (Business Logic)
        ↓
Repository Layer (Abstract Interface)
        ↓
Data Layer (drift/SQLite + JSON Assets)
```

- **Feature-first** — each module (home, record, statistics, knowledge, settings) is self-contained
- **Repository pattern** — abstract interfaces for future cloud sync capability
- **Stream-based** — reactive UI via `watchRecords()` streams

---

## Roadmap

- [x] 8 record types with quick entry
- [x] Today overview dashboard
- [x] Statistics with charts
- [x] WHO growth curves (0-24 months)
- [x] Knowledge base by age range
- [x] Multi-baby support with instant switching
- [x] 4 theme skins (Claymorphism style)
- [x] Full-screen record form with delete confirmation
- [x] Multi-language support (zh / en / ja / ko)
- [x] Feeding interval reminder notifications
- [x] Growth data plotted on WHO curve chart (full history)
- [ ] Dark mode
- [ ] Cloud sync (optional)
- [ ] Family sharing

---

## License

MIT © [yideng-xl](https://github.com/yideng-xl)
