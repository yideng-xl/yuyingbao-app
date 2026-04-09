// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class SKo extends S {
  SKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '육아보';

  @override
  String get navHome => '홈';

  @override
  String get navRecords => '기록';

  @override
  String get navStatistics => '통계';

  @override
  String get navKnowledge => '지식';

  @override
  String get navSettings => '설정';

  @override
  String get switchBaby => '아기 전환';

  @override
  String get todayOverview => '오늘의 요약';

  @override
  String get feedingCount => '수유';

  @override
  String get feedingCountUnit => '회';

  @override
  String get milkVolume => '우유량';

  @override
  String get diaperCount => '기저귀';

  @override
  String get diaperCountUnit => '회';

  @override
  String get waterVolume => '수분';

  @override
  String get recentRecords => '최근 기록';

  @override
  String get noRecordsYet => '아직 기록이 없습니다. 추가해 보세요!';

  @override
  String get noBabyYet => '아기가 등록되지 않았습니다. 먼저 추가해 주세요';

  @override
  String get addRecord => '기록 추가';

  @override
  String get addBabyFirst => '먼저 아기를 추가해 주세요';

  @override
  String get addBabyFirstInfo => '먼저 아기 정보를 추가해 주세요';

  @override
  String get recordTypeBreastfeeding => '모유 수유';

  @override
  String get recordTypeBottle => '젖병 수유';

  @override
  String get recordTypeFormula => '분유';

  @override
  String get recordTypeSolid => '이유식';

  @override
  String get recordTypeDiaper => '기저귀';

  @override
  String get recordTypeGrowth => '성장 기록';

  @override
  String get recordTypeWater => '수분';

  @override
  String get recordTypeNutrition => '영양제';

  @override
  String get breastfeedingSideLeft => '왼쪽';

  @override
  String get breastfeedingSideRight => '오른쪽';

  @override
  String get breastfeedingSideBoth => '양쪽';

  @override
  String get solidTypeRiceCereal => '쌀 미음';

  @override
  String get solidTypeVegetablePuree => '야채 퓨레';

  @override
  String get solidTypeFruitPuree => '과일 퓨레';

  @override
  String get solidTypeMeatPuree => '고기 퓨레';

  @override
  String get solidTypeEggYolk => '달걀 노른자';

  @override
  String get solidTypeOther => '기타';

  @override
  String get diaperTextureWatery => '물 같은';

  @override
  String get diaperTextureSoft => '부드러운';

  @override
  String get diaperTextureNormal => '보통';

  @override
  String get diaperTextureHard => '단단한';

  @override
  String get diaperColorYellow => '노란색';

  @override
  String get diaperColorGreen => '초록색';

  @override
  String get diaperColorBrown => '갈색';

  @override
  String get diaperColorBlack => '검은색';

  @override
  String get genderMale => '남';

  @override
  String get genderFemale => '여';

  @override
  String get genderBoy => '남아';

  @override
  String get genderGirl => '여아';

  @override
  String get skinWarmPink => '웜 핑크';

  @override
  String get skinWarmPinkDesc => '따뜻한 핑크 톤';

  @override
  String get skinOceanBlue => '오션 블루';

  @override
  String get skinOceanBlueDesc => '시원한 블루 톤';

  @override
  String get skinNatureGreen => '네이처 그린';

  @override
  String get skinNatureGreenDesc => '신선한 그린 톤';

  @override
  String get skinSunnyOrange => '써니 오렌지';

  @override
  String get skinSunnyOrangeDesc => '활기찬 오렌지 톤';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get dayBeforeYesterday => '그저께';

  @override
  String get edit => '편집';

  @override
  String get delete => '삭제';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get recordType => '기록 유형';

  @override
  String get time => '시간';

  @override
  String get noteOptional => '메모 (선택)';

  @override
  String get breastfeedingSide => '수유 방향';

  @override
  String get durationMinutes => '시간 (분)';

  @override
  String get solidType => '이유식 종류';

  @override
  String get ingredientOptional => '재료 (선택)';

  @override
  String get texture => '형태';

  @override
  String get color => '색상';

  @override
  String get hasUrine => '소변';

  @override
  String get hasUrineText => '소변 있음';

  @override
  String get nutritionType => '영양제 종류';

  @override
  String get babyManagement => '아기 관리';

  @override
  String get noBabyInfo => '아기 정보가 없습니다';

  @override
  String get deleteBaby => '아기 삭제';

  @override
  String deleteBabyConfirm(String name) {
    return '「$name」의 모든 정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get editBaby => '아기 편집';

  @override
  String get addBaby => '아기 추가';

  @override
  String get babyName => '이름';

  @override
  String get babyNameHint => '아기 이름을 입력하세요';

  @override
  String get babyNameRequired => '이름을 입력해 주세요';

  @override
  String get gender => '성별';

  @override
  String get birthDate => '생년월일';

  @override
  String get optional => '선택';

  @override
  String get invalidNumber => '유효한 숫자를 입력해 주세요';

  @override
  String get sectionTheme => '테마';

  @override
  String get sectionBabyManagement => '아기 관리';

  @override
  String get sectionAbout => '정보';

  @override
  String get addBabyHint => '+를 눌러 아기를 추가하세요';

  @override
  String get appName => '육아보';

  @override
  String version(String version) {
    return '버전 $version';
  }

  @override
  String get openSource => '소스 코드';

  @override
  String get feedingVolumeTitle => '수유량 (ml)';

  @override
  String get whoWeightTitle => 'WHO 체중 곡선 (kg)';

  @override
  String get whoHeightTitle => 'WHO 신장 곡선 (cm)';

  @override
  String get diaperCountTitle => '기저귀 교체 횟수';

  @override
  String get weight => '체중';

  @override
  String get height => '신장';

  @override
  String get noReferenceData => '참고 데이터 없음';

  @override
  String get noFeedingData => '수유 데이터 없음';

  @override
  String get noDiaperData => '기저귀 데이터 없음';

  @override
  String get baby => '아기';

  @override
  String loadError(String error) {
    return '로딩 실패: $error';
  }

  @override
  String monthLabel(String month) {
    return '$month개월';
  }

  @override
  String get timeRangeToday => '오늘';

  @override
  String get timeRangeWeek => '7일';

  @override
  String get timeRangeMonth => '30일';

  @override
  String get prevDay => '이전 날';

  @override
  String get nextDay => '다음 날';

  @override
  String get confirmDelete => '삭제 확인';

  @override
  String get confirmDeleteRecord => '이 기록을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get knowledgeTitle => '육아 지식';

  @override
  String get knowledgeAll => '전체';

  @override
  String get knowledgeCategoryFeeding => '수유';

  @override
  String get knowledgeCategoryHealth => '건강';

  @override
  String get knowledgeCategoryDevelopment => '발달';

  @override
  String get knowledgeCategorySolid => '이유식';

  @override
  String get noArticles => '관련 글이 없습니다';

  @override
  String get feedingReminder => '수유 알림';

  @override
  String get feedingReminderDesc => '일정 간격으로 수유 알림';

  @override
  String get feedingReminderEnabled => '알림 켜기';

  @override
  String get feedingIntervalHours => '간격 (시간)';

  @override
  String get feedingReminderNotification => '아기 수유 시간입니다!';

  @override
  String get feedingReminderTitle => '수유 알림';

  @override
  String get sectionLanguage => '언어';

  @override
  String get languageFollowSystem => '시스템 설정';

  @override
  String get language => '언어';

  @override
  String get languageZh => '中文';

  @override
  String get languageEn => 'English';

  @override
  String get languageJa => '日本語';

  @override
  String get languageKo => '한국어';

  @override
  String get birthHeightLabel => '출생 시 신장 (cm)';

  @override
  String get birthWeightLabel => '출생 시 체중 (kg)';

  @override
  String get birthPrefix => '출생';

  @override
  String monthsAgo(String months) {
    return '$months 개월';
  }

  @override
  String get saveFailed => '저장 실패';

  @override
  String get loadFailure => '로딩 실패';

  @override
  String get tapToAddBaby => '+를 눌러 아기를 추가하세요';

  @override
  String confirmDeleteBaby(String name) {
    return '「$name」의 모든 정보를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get searchArticles => '글 검색...';

  @override
  String get ageRange0To6 => '0-6개월';

  @override
  String get ageRange6To12 => '6-12개월';

  @override
  String get ageRange12To24 => '12-24개월';

  @override
  String get amountMl => '양 (ml)';

  @override
  String get heightCm => '신장 (cm)';

  @override
  String get weightKg => '체중 (kg)';

  @override
  String recordLoadFailed(String error) {
    return '로딩 실패: $error';
  }

  @override
  String timesPerDay(int count) {
    return '$count회';
  }

  @override
  String diaperChangesCount(int count) {
    return '$count회 기저귀 교체';
  }

  @override
  String get durationMinutesUnit => '분';

  @override
  String get amountMlUnit => 'ml';

  @override
  String get heightCmUnit => 'cm';

  @override
  String get weightKgUnit => 'kg';

  @override
  String deleteRecordConfirm(Object recordType) {
    return '이 $recordType 기록을 삭제하시겠습니까?';
  }
}
