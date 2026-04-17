<div align="center">

# 육아보 (YuyingBao)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Version](https://img.shields.io/badge/version-0.6.0-EC4899)](https://github.com/yideng-xl/yuyingbao-app/releases)

[English](./README.md) | [中文](./README.zh-CN.md) | [日本語](./README.ja.md) | 한국어

Flutter로 구축한 로컬 우선 육아 기록 앱 — 클라우드 없이, 계정 없이, 데이터는 완전히 내 손 안에.

</div>

---

## 스크린샷

> 곧 공개 예정

---

## 기능

- **다중 아기 관리** — 여러 아기 프로필 관리, 어느 페이지에서든 원탭으로 전환
- **8가지 기록 유형** — 모유 직수, 젖병, 분유, 이유식, 기저귀, 성장 기록, 수분, 영양 보충
- **오늘의 요약** — 대시보드에서 수유 횟수, 총 우유량, 기저귀 교체 횟수, 수분 섭취량 확인
- **빠른 기록** — 자주 사용하는 작업 원탭 입력, 전체 화면 폼으로 간편 입력
- **통계 데이터** — 수유량 막대 그래프, 기저귀 트렌드 꺾은선 그래프
- **WHO 성장 곡선** — 0~24개월, P3 / P15 / P50 / P85 / P97 백분위선
- **육아 지식 베이스** — 월령별 Markdown 리치 텍스트 기사, 검색 및 필터 지원
- **4가지 테마 스킨** — 웜 핑크, 오션 블루, 네이처 그린, 서니 오렌지, 설정에서 즉시 전환
- **Claymorphism UI** — 부드러운 3D, 둥근 모서리, 은은한 그림자로 따뜻한 디자인
- **다국어 지원** — 중국어, 영어, 일본어, 한국어, 설정에서 즉시 전환
- **수유 알림** — 고정 간격 알림으로 수유 시간을 놓치지 않기
- **성장 곡선 오버레이** — 아기의 전체 기록 데이터를 WHO 백분위 곡선 위에 표시
- **100% 로컬 저장** — 클라우드 없음, 계정 없음, 데이터가 기기를 떠나지 않음
- **크로스 플랫폼** — iOS 및 Android 지원

---

## 기술 스택

| 레이어 | 기술 |
|---|---|
| UI 프레임워크 | Flutter 3.x |
| 상태 관리 | Riverpod + flutter_hooks |
| 로컬 DB | drift (SQLite) |
| 라우팅 | go_router |
| 차트 | fl_chart |
| Markdown 렌더링 | flutter_markdown |
| 로컬 알림 | flutter_local_notifications |
| 국제화 | flutter_localizations + ARB |
| 테마 | flex_color_scheme |

---

## 테마 스킨

| 스킨 | 메인 컬러 | 스타일 |
|---|---|---|
| 웜 핑크 | `#EC4899` | 달콤하고 따뜻한, 엄마에게 딱 |
| 오션 블루 | `#3B82F6` | 시원하고 차분한, 아빠에게 딱 |
| 네이처 그린 | `#10B981` | 신선하고 자연스러운, 젠더 뉴트럴 |
| 서니 오렌지 | `#F97316` | 활기 넘치는, 따뜻한 분위기 |

---

## 시작하기

### 사전 요구 사항

- Flutter SDK 3.24+ ([설치 가이드](https://docs.flutter.dev/get-started/install))
- Xcode (iOS 개발) 또는 Android Studio (Android 개발)

### 설치 및 실행

```bash
git clone https://github.com/yideng-xl/yuyingbao-app.git
cd yuyingbao-app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## 아키텍처

```
UI 레이어 (Flutter Widgets)
        ↓
상태 관리 레이어 (Riverpod Providers)
        ↓
서비스 레이어 (비즈니스 로직)
        ↓
리포지토리 레이어 (추상 인터페이스)
        ↓
데이터 레이어 (drift/SQLite + JSON 에셋)
```

- **Feature-first 구조** — 각 기능 모듈(홈, 기록, 통계, 지식, 설정)이 독립적으로 구성
- **Repository 패턴** — 향후 클라우드 동기화를 위한 추상 인터페이스 설계
- **리액티브 UI** — `watchRecords()` Stream 기반 실시간 데이터 업데이트

---

## 로드맵

- [x] 8가지 기록 유형과 빠른 입력
- [x] 오늘의 요약 대시보드
- [x] 차트 데이터 통계
- [x] WHO 성장 곡선 (0~24개월)
- [x] 월령별 지식 베이스
- [x] 다중 아기 지원, 어디서든 전환
- [x] 4가지 테마 스킨 (Claymorphism 스타일)
- [x] 전체 화면 기록 폼 + 삭제 확인
- [x] 다국어 지원 (중 / 영 / 일 / 한)
- [x] 수유 간격 알림 통지
- [x] 성장 데이터를 WHO 곡선 위에 표시 (전체 기록)
- [ ] 다크 모드
- [ ] 클라우드 동기화 (선택)
- [ ] 가족 공유

---

## 라이선스

MIT © [yideng-xl](https://github.com/yideng-xl)
