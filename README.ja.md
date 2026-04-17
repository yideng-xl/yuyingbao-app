<div align="center">

# 育児宝 (YuyingBao)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-0.6.0-EC4899)](https://github.com/yideng-xl/yuyingbao-app/releases)

[English](./README.md) | [中文](./README.zh-CN.md) | 日本語 | [한국어](./README.ko.md)

Flutter で構築されたローカルファーストの育児記録アプリ — クラウド不要、アカウント不要、データは完全にあなたの手元に。

</div>

---

## スクリーンショット

> 近日公開

---

## 機能

- **複数の赤ちゃん管理** — 複数の赤ちゃんプロフィールを管理、どのページからでもワンタップで切り替え
- **8種類の記録** — 母乳直接授乳、哺乳瓶、粉ミルク、離乳食、おむつ、成長記録、水分、栄養補助
- **今日の概要** — ダッシュボードに授乳回数、総ミルク量、おむつ交換回数、水分摂取量を表示
- **クイック記録** — よく使う操作をワンタップで入力、フルスクリーンフォームで簡単入力
- **統計データ** — 授乳量の棒グラフ、おむつトレンドの折れ線グラフ
- **WHO成長曲線** — 0〜24ヶ月、P3 / P15 / P50 / P85 / P97パーセンタイル線
- **育児ナレッジベース** — 月齢別のMarkdownリッチテキスト記事、検索・フィルター対応
- **4つのテーマスキン** — ウォームピンク、オーシャンブルー、ナチュラルグリーン、サニーオレンジ、設定から即時切り替え
- **Claymorphism UI** — ソフトな3D、丸い角、優しいシャドウで温かみのあるデザイン
- **多言語対応** — 中国語、英語、日本語、韓国語、設定から即時切り替え
- **授乳リマインダー** — 固定間隔の通知で授乳を忘れない
- **成長曲線オーバーレイ** — 赤ちゃんの全履歴データをWHOパーセンタイル曲線上に表示
- **100%ローカル保存** — クラウド不要、アカウント不要、データはデバイスから出ません
- **クロスプラットフォーム** — iOS・Android対応

---

## 技術スタック

| レイヤー | 技術 |
|---|---|
| UIフレームワーク | Flutter 3.x |
| 状態管理 | Riverpod + flutter_hooks |
| ローカルDB | drift (SQLite) |
| ルーティング | go_router |
| チャート | fl_chart |
| Markdownレンダリング | flutter_markdown |
| ローカル通知 | flutter_local_notifications |
| 国際化 | flutter_localizations + ARB |
| テーマ | flex_color_scheme |

---

## テーマスキン

| スキン | メインカラー | スタイル |
|---|---|---|
| ウォームピンク | `#EC4899` | 甘くて温かい、ママにぴったり |
| オーシャンブルー | `#3B82F6` | 爽やかで落ち着いた、パパにぴったり |
| ナチュラルグリーン | `#10B981` | フレッシュで自然、ジェンダーニュートラル |
| サニーオレンジ | `#F97316` | 元気いっぱい、暖かい雰囲気 |

---

## はじめに

### 前提条件

- Flutter SDK 3.24+（[インストールガイド](https://docs.flutter.dev/get-started/install)）
- Xcode（iOS開発）またはAndroid Studio（Android開発）

### インストール＆実行

```bash
git clone https://github.com/yideng-xl/yuyingbao-app.git
cd yuyingbao-app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## アーキテクチャ

```
UIレイヤー（Flutter Widgets）
        ↓
状態管理レイヤー（Riverpod Providers）
        ↓
サービスレイヤー（ビジネスロジック）
        ↓
リポジトリレイヤー（抽象インターフェース）
        ↓
データレイヤー（drift/SQLite + JSONアセット）
```

- **Feature-first構成** — 各機能モジュール（ホーム、記録、統計、ナレッジ、設定）が自己完結
- **Repositoryパターン** — 将来のクラウド同期に備えた抽象インターフェース設計
- **リアクティブUI** — `watchRecords()` Streamによるリアルタイムデータ更新

---

## ロードマップ

- [x] 8種類の記録とクイック入力
- [x] 今日の概要ダッシュボード
- [x] チャートによるデータ統計
- [x] WHO成長曲線（0〜24ヶ月）
- [x] 月齢別ナレッジベース
- [x] 複数の赤ちゃん対応、どのページからでも切り替え
- [x] 4つのテーマスキン（Claymorphismスタイル）
- [x] フルスクリーン記録フォーム＋削除確認
- [x] 多言語対応（中 / 英 / 日 / 韓）
- [x] 授乳間隔リマインダー通知
- [x] 成長データをWHO曲線上に表示（全履歴）
- [ ] ダークモード
- [ ] クラウド同期（オプション）
- [ ] ファミリー共有

---

## ライセンス

MIT © [yideng-xl](https://github.com/yideng-xl)
