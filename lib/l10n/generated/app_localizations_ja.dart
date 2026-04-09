// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class SJa extends S {
  SJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '育児宝';

  @override
  String get navHome => 'ホーム';

  @override
  String get navRecords => '記録';

  @override
  String get navStatistics => '統計';

  @override
  String get navKnowledge => '知識';

  @override
  String get navSettings => '設定';

  @override
  String get switchBaby => '赤ちゃん切替';

  @override
  String get todayOverview => '今日のまとめ';

  @override
  String get feedingCount => '授乳';

  @override
  String get feedingCountUnit => '回';

  @override
  String get milkVolume => 'ミルク量';

  @override
  String get diaperCount => 'おむつ替え';

  @override
  String get diaperCountUnit => '回';

  @override
  String get waterVolume => '水分量';

  @override
  String get recentRecords => '最近の記録';

  @override
  String get noRecordsYet => 'まだ記録がありません。追加しましょう！';

  @override
  String get noBabyYet => '赤ちゃんがまだ登録されていません。先に追加してください';

  @override
  String get addRecord => '記録を追加';

  @override
  String get addBabyFirst => '先に赤ちゃんを追加してください';

  @override
  String get addBabyFirstInfo => '先に赤ちゃん情報を追加してください';

  @override
  String get recordTypeBreastfeeding => '母乳';

  @override
  String get recordTypeBottle => '哺乳瓶';

  @override
  String get recordTypeFormula => 'ミルク';

  @override
  String get recordTypeSolid => '離乳食';

  @override
  String get recordTypeDiaper => 'おむつ';

  @override
  String get recordTypeGrowth => '成長記録';

  @override
  String get recordTypeWater => '水分';

  @override
  String get recordTypeNutrition => 'サプリメント';

  @override
  String get breastfeedingSideLeft => '左';

  @override
  String get breastfeedingSideRight => '右';

  @override
  String get breastfeedingSideBoth => '両方';

  @override
  String get solidTypeRiceCereal => 'おかゆ';

  @override
  String get solidTypeVegetablePuree => '野菜ペースト';

  @override
  String get solidTypeFruitPuree => '果物ペースト';

  @override
  String get solidTypeMeatPuree => '肉ペースト';

  @override
  String get solidTypeEggYolk => '卵黄';

  @override
  String get solidTypeOther => 'その他';

  @override
  String get diaperTextureWatery => '水様';

  @override
  String get diaperTextureSoft => '軟便';

  @override
  String get diaperTextureNormal => '普通';

  @override
  String get diaperTextureHard => '硬い';

  @override
  String get diaperColorYellow => '黄色';

  @override
  String get diaperColorGreen => '緑色';

  @override
  String get diaperColorBrown => '茶色';

  @override
  String get diaperColorBlack => '黒色';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get genderBoy => '男の子';

  @override
  String get genderGirl => '女の子';

  @override
  String get skinWarmPink => 'ウォームピンク';

  @override
  String get skinWarmPinkDesc => '温かみのあるピンク';

  @override
  String get skinOceanBlue => 'オーシャンブルー';

  @override
  String get skinOceanBlueDesc => '爽やかな青';

  @override
  String get skinNatureGreen => 'ナチュラルグリーン';

  @override
  String get skinNatureGreenDesc => '新鮮な緑';

  @override
  String get skinSunnyOrange => 'サニーオレンジ';

  @override
  String get skinSunnyOrangeDesc => '元気なオレンジ';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get dayBeforeYesterday => '一昨日';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get recordType => '記録タイプ';

  @override
  String get time => '時間';

  @override
  String get noteOptional => 'メモ（任意）';

  @override
  String get breastfeedingSide => '授乳側';

  @override
  String get durationMinutes => '時間（分）';

  @override
  String get solidType => '離乳食タイプ';

  @override
  String get ingredientOptional => '食材（任意）';

  @override
  String get texture => '形状';

  @override
  String get color => '色';

  @override
  String get hasUrine => 'おしっこ';

  @override
  String get hasUrineText => 'おしっこあり';

  @override
  String get nutritionType => 'サプリメント種類';

  @override
  String get babyManagement => '赤ちゃん管理';

  @override
  String get noBabyInfo => '赤ちゃん情報がありません';

  @override
  String get deleteBaby => '赤ちゃん削除';

  @override
  String deleteBabyConfirm(String name) {
    return '「$name」のすべての情報を削除しますか？この操作は取り消せません。';
  }

  @override
  String get editBaby => '赤ちゃん編集';

  @override
  String get addBaby => '赤ちゃん追加';

  @override
  String get babyName => '名前';

  @override
  String get babyNameHint => '赤ちゃんの名前を入力';

  @override
  String get babyNameRequired => '名前を入力してください';

  @override
  String get gender => '性別';

  @override
  String get birthDate => '生年月日';

  @override
  String get optional => '任意';

  @override
  String get invalidNumber => '有効な数字を入力してください';

  @override
  String get sectionTheme => 'テーマ';

  @override
  String get sectionBabyManagement => '赤ちゃん管理';

  @override
  String get sectionAbout => 'アプリについて';

  @override
  String get addBabyHint => '＋をタップして赤ちゃんを追加';

  @override
  String get appName => '育児宝';

  @override
  String version(String version) {
    return 'バージョン $version';
  }

  @override
  String get openSource => 'ソースコード';

  @override
  String get feedingVolumeTitle => '授乳量（ml）';

  @override
  String get whoWeightTitle => 'WHO 体重曲線（kg）';

  @override
  String get whoHeightTitle => 'WHO 身長曲線（cm）';

  @override
  String get diaperCountTitle => 'おむつ替え回数';

  @override
  String get weight => '体重';

  @override
  String get height => '身長';

  @override
  String get noReferenceData => '参考データなし';

  @override
  String get noFeedingData => '授乳データなし';

  @override
  String get noDiaperData => 'おむつデータなし';

  @override
  String get baby => '赤ちゃん';

  @override
  String loadError(String error) {
    return '読み込み失敗: $error';
  }

  @override
  String monthLabel(String month) {
    return '$monthヶ月';
  }

  @override
  String get timeRangeToday => '今日';

  @override
  String get timeRangeWeek => '7日間';

  @override
  String get timeRangeMonth => '30日間';

  @override
  String get prevDay => '前の日';

  @override
  String get nextDay => '次の日';

  @override
  String get confirmDelete => '削除確認';

  @override
  String get confirmDeleteRecord => 'この記録を削除しますか？この操作は取り消せません。';

  @override
  String get knowledgeTitle => '育児知識';

  @override
  String get knowledgeAll => 'すべて';

  @override
  String get knowledgeCategoryFeeding => '授乳';

  @override
  String get knowledgeCategoryHealth => '健康';

  @override
  String get knowledgeCategoryDevelopment => '発達';

  @override
  String get knowledgeCategorySolid => '離乳食';

  @override
  String get noArticles => '記事がありません';

  @override
  String get feedingReminder => '授乳リマインダー';

  @override
  String get feedingReminderDesc => '一定間隔で授乳を通知';

  @override
  String get feedingReminderEnabled => 'リマインダーON';

  @override
  String get feedingIntervalHours => '間隔（時間）';

  @override
  String get feedingReminderNotification => '赤ちゃんの授乳時間です！';

  @override
  String get feedingReminderTitle => '授乳リマインダー';

  @override
  String get sectionLanguage => '言語';

  @override
  String get languageFollowSystem => 'システム設定に従う';

  @override
  String get language => '言語';

  @override
  String get languageZh => '中文';

  @override
  String get languageEn => 'English';

  @override
  String get languageJa => '日本語';

  @override
  String get languageKo => '한국어';

  @override
  String get birthHeightLabel => '出生時身長 (cm)';

  @override
  String get birthWeightLabel => '出生時体重 (kg)';

  @override
  String get birthPrefix => '生まれ';

  @override
  String monthsAgo(String months) {
    return '$months ヶ月';
  }

  @override
  String get saveFailed => '保存に失敗しました';

  @override
  String get loadFailure => '読み込み失敗';

  @override
  String get tapToAddBaby => '＋をタップして赤ちゃんを追加';

  @override
  String confirmDeleteBaby(String name) {
    return '「$name」のすべての情報を削除しますか？この操作は取り消せません。';
  }

  @override
  String get searchArticles => '記事を検索...';

  @override
  String get ageRange0To6 => '0-6ヶ月';

  @override
  String get ageRange6To12 => '6-12ヶ月';

  @override
  String get ageRange12To24 => '12-24ヶ月';

  @override
  String get amountMl => '量（ml）';

  @override
  String get heightCm => '身長（cm）';

  @override
  String get weightKg => '体重（kg）';

  @override
  String recordLoadFailed(String error) {
    return '読み込み失敗：$error';
  }

  @override
  String timesPerDay(int count) {
    return '$count回';
  }

  @override
  String diaperChangesCount(int count) {
    return '$count回おむつ替え';
  }

  @override
  String get durationMinutesUnit => '分';

  @override
  String get amountMlUnit => 'ml';

  @override
  String get heightCmUnit => 'cm';

  @override
  String get weightKgUnit => 'kg';

  @override
  String deleteRecordConfirm(Object recordType) {
    return 'この$recordType記録を削除しますか？';
  }
}
