<div align="center">

# YuyingBao (育婴宝)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)

[中文](./README.zh-CN.md) | English

A local-first baby care tracking app built with Flutter — no cloud, no account, just your data.

</div>

---

## Screenshots

> Coming soon

---

## Features

- **Multi-baby support** — manage profiles for multiple babies in one app
- **8 record types** — breastfeeding, bottle feeding, formula, solid food, diaper, growth, water, and nutrition
- **Today overview** — daily summary dashboard at a glance
- **Quick record** — one-tap buttons for the most frequent actions
- **Statistics** — bar and line charts for feeding and growth trends
- **WHO growth curves** — 0–24 months, P3 / P15 / P50 / P85 / P97 percentile lines
- **Knowledge base** — age-appropriate baby care articles
- **Data export / import** — full JSON backup and restore
- **100% local** — no cloud, no account, no data leaves your device
- **Cross-platform** — iOS and Android

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI Framework | Flutter |
| State Management | Riverpod + flutter_hooks |
| Local Database | drift (SQLite) |
| Navigation | go_router |
| Charts | fl_chart |
| Theming | flex_color_scheme |

---

## Getting Started

### Prerequisites

- Flutter SDK 3.x ([install guide](https://docs.flutter.dev/get-started/install))
- Dart SDK (bundled with Flutter)

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

---

## Data Format

Records are exported as JSON. Example:

```json
{
  "exportedAt": "2025-01-01T00:00:00Z",
  "babies": [
    {
      "id": "uuid",
      "name": "Baby",
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

## Roadmap

- [x] 8 record types with quick entry
- [x] Today overview dashboard
- [x] Statistics with charts
- [x] WHO growth curves (0–24 months)
- [x] Knowledge base by age range
- [x] Multi-baby support
- [ ] Data export / import (file picker)
- [ ] Feeding interval notifications
- [ ] Growth data plotted on WHO curve chart
- [ ] Dark mode
- [ ] Cloud sync (optional)
- [ ] Family sharing

---

## License

MIT © [yideng-xl](https://github.com/yideng-xl)
