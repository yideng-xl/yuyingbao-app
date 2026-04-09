import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh, this message translates to:
  /// **'育婴宝'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get navHome;

  /// No description provided for @navRecords.
  ///
  /// In zh, this message translates to:
  /// **'记录'**
  String get navRecords;

  /// No description provided for @navStatistics.
  ///
  /// In zh, this message translates to:
  /// **'统计'**
  String get navStatistics;

  /// No description provided for @navKnowledge.
  ///
  /// In zh, this message translates to:
  /// **'知识'**
  String get navKnowledge;

  /// No description provided for @navSettings.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get navSettings;

  /// No description provided for @switchBaby.
  ///
  /// In zh, this message translates to:
  /// **'切换宝宝'**
  String get switchBaby;

  /// No description provided for @todayOverview.
  ///
  /// In zh, this message translates to:
  /// **'今日概览'**
  String get todayOverview;

  /// No description provided for @feedingCount.
  ///
  /// In zh, this message translates to:
  /// **'喂奶'**
  String get feedingCount;

  /// No description provided for @feedingCountUnit.
  ///
  /// In zh, this message translates to:
  /// **'次'**
  String get feedingCountUnit;

  /// No description provided for @milkVolume.
  ///
  /// In zh, this message translates to:
  /// **'奶量'**
  String get milkVolume;

  /// No description provided for @diaperCount.
  ///
  /// In zh, this message translates to:
  /// **'换尿布'**
  String get diaperCount;

  /// No description provided for @diaperCountUnit.
  ///
  /// In zh, this message translates to:
  /// **'次'**
  String get diaperCountUnit;

  /// No description provided for @waterVolume.
  ///
  /// In zh, this message translates to:
  /// **'饮水'**
  String get waterVolume;

  /// No description provided for @recentRecords.
  ///
  /// In zh, this message translates to:
  /// **'最近记录'**
  String get recentRecords;

  /// No description provided for @noRecordsYet.
  ///
  /// In zh, this message translates to:
  /// **'还没有记录，快去添加吧'**
  String get noRecordsYet;

  /// No description provided for @noBabyYet.
  ///
  /// In zh, this message translates to:
  /// **'还没有添加宝宝，请先添加宝宝'**
  String get noBabyYet;

  /// No description provided for @addRecord.
  ///
  /// In zh, this message translates to:
  /// **'添加记录'**
  String get addRecord;

  /// No description provided for @addBabyFirst.
  ///
  /// In zh, this message translates to:
  /// **'请先添加宝宝'**
  String get addBabyFirst;

  /// No description provided for @addBabyFirstInfo.
  ///
  /// In zh, this message translates to:
  /// **'请先添加宝宝信息'**
  String get addBabyFirstInfo;

  /// No description provided for @recordTypeBreastfeeding.
  ///
  /// In zh, this message translates to:
  /// **'母乳亲喂'**
  String get recordTypeBreastfeeding;

  /// No description provided for @recordTypeBottle.
  ///
  /// In zh, this message translates to:
  /// **'瓶喂'**
  String get recordTypeBottle;

  /// No description provided for @recordTypeFormula.
  ///
  /// In zh, this message translates to:
  /// **'配方奶'**
  String get recordTypeFormula;

  /// No description provided for @recordTypeSolid.
  ///
  /// In zh, this message translates to:
  /// **'辅食'**
  String get recordTypeSolid;

  /// No description provided for @recordTypeDiaper.
  ///
  /// In zh, this message translates to:
  /// **'尿布'**
  String get recordTypeDiaper;

  /// No description provided for @recordTypeGrowth.
  ///
  /// In zh, this message translates to:
  /// **'成长记录'**
  String get recordTypeGrowth;

  /// No description provided for @recordTypeWater.
  ///
  /// In zh, this message translates to:
  /// **'饮水'**
  String get recordTypeWater;

  /// No description provided for @recordTypeNutrition.
  ///
  /// In zh, this message translates to:
  /// **'营养补充'**
  String get recordTypeNutrition;

  /// No description provided for @breastfeedingSideLeft.
  ///
  /// In zh, this message translates to:
  /// **'左侧'**
  String get breastfeedingSideLeft;

  /// No description provided for @breastfeedingSideRight.
  ///
  /// In zh, this message translates to:
  /// **'右侧'**
  String get breastfeedingSideRight;

  /// No description provided for @breastfeedingSideBoth.
  ///
  /// In zh, this message translates to:
  /// **'双侧'**
  String get breastfeedingSideBoth;

  /// No description provided for @solidTypeRiceCereal.
  ///
  /// In zh, this message translates to:
  /// **'米粉'**
  String get solidTypeRiceCereal;

  /// No description provided for @solidTypeVegetablePuree.
  ///
  /// In zh, this message translates to:
  /// **'蔬菜泥'**
  String get solidTypeVegetablePuree;

  /// No description provided for @solidTypeFruitPuree.
  ///
  /// In zh, this message translates to:
  /// **'水果泥'**
  String get solidTypeFruitPuree;

  /// No description provided for @solidTypeMeatPuree.
  ///
  /// In zh, this message translates to:
  /// **'肉泥'**
  String get solidTypeMeatPuree;

  /// No description provided for @solidTypeEggYolk.
  ///
  /// In zh, this message translates to:
  /// **'蛋黄'**
  String get solidTypeEggYolk;

  /// No description provided for @solidTypeOther.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get solidTypeOther;

  /// No description provided for @diaperTextureWatery.
  ///
  /// In zh, this message translates to:
  /// **'稀水样'**
  String get diaperTextureWatery;

  /// No description provided for @diaperTextureSoft.
  ///
  /// In zh, this message translates to:
  /// **'软便'**
  String get diaperTextureSoft;

  /// No description provided for @diaperTextureNormal.
  ///
  /// In zh, this message translates to:
  /// **'正常'**
  String get diaperTextureNormal;

  /// No description provided for @diaperTextureHard.
  ///
  /// In zh, this message translates to:
  /// **'干硬'**
  String get diaperTextureHard;

  /// No description provided for @diaperColorYellow.
  ///
  /// In zh, this message translates to:
  /// **'黄色'**
  String get diaperColorYellow;

  /// No description provided for @diaperColorGreen.
  ///
  /// In zh, this message translates to:
  /// **'绿色'**
  String get diaperColorGreen;

  /// No description provided for @diaperColorBrown.
  ///
  /// In zh, this message translates to:
  /// **'褐色'**
  String get diaperColorBrown;

  /// No description provided for @diaperColorBlack.
  ///
  /// In zh, this message translates to:
  /// **'黑色'**
  String get diaperColorBlack;

  /// No description provided for @genderMale.
  ///
  /// In zh, this message translates to:
  /// **'男'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In zh, this message translates to:
  /// **'女'**
  String get genderFemale;

  /// No description provided for @genderBoy.
  ///
  /// In zh, this message translates to:
  /// **'男宝'**
  String get genderBoy;

  /// No description provided for @genderGirl.
  ///
  /// In zh, this message translates to:
  /// **'女宝'**
  String get genderGirl;

  /// No description provided for @skinWarmPink.
  ///
  /// In zh, this message translates to:
  /// **'温馨粉'**
  String get skinWarmPink;

  /// No description provided for @skinWarmPinkDesc.
  ///
  /// In zh, this message translates to:
  /// **'柔粉色调，温馨甜蜜'**
  String get skinWarmPinkDesc;

  /// No description provided for @skinOceanBlue.
  ///
  /// In zh, this message translates to:
  /// **'清新蓝'**
  String get skinOceanBlue;

  /// No description provided for @skinOceanBlueDesc.
  ///
  /// In zh, this message translates to:
  /// **'蓝色系，清爽沉稳'**
  String get skinOceanBlueDesc;

  /// No description provided for @skinNatureGreen.
  ///
  /// In zh, this message translates to:
  /// **'自然绿'**
  String get skinNatureGreen;

  /// No description provided for @skinNatureGreenDesc.
  ///
  /// In zh, this message translates to:
  /// **'绿色系，清新自然'**
  String get skinNatureGreenDesc;

  /// No description provided for @skinSunnyOrange.
  ///
  /// In zh, this message translates to:
  /// **'暖阳橙'**
  String get skinSunnyOrange;

  /// No description provided for @skinSunnyOrangeDesc.
  ///
  /// In zh, this message translates to:
  /// **'暖橙色调，活力满满'**
  String get skinSunnyOrangeDesc;

  /// No description provided for @today.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In zh, this message translates to:
  /// **'昨天'**
  String get yesterday;

  /// No description provided for @dayBeforeYesterday.
  ///
  /// In zh, this message translates to:
  /// **'前天'**
  String get dayBeforeYesterday;

  /// No description provided for @edit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @recordType.
  ///
  /// In zh, this message translates to:
  /// **'记录类型'**
  String get recordType;

  /// No description provided for @time.
  ///
  /// In zh, this message translates to:
  /// **'时间'**
  String get time;

  /// No description provided for @noteOptional.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get noteOptional;

  /// No description provided for @breastfeedingSide.
  ///
  /// In zh, this message translates to:
  /// **'喂奶侧'**
  String get breastfeedingSide;

  /// No description provided for @durationMinutes.
  ///
  /// In zh, this message translates to:
  /// **'时长（分钟）'**
  String get durationMinutes;

  /// No description provided for @solidType.
  ///
  /// In zh, this message translates to:
  /// **'辅食类型'**
  String get solidType;

  /// No description provided for @ingredientOptional.
  ///
  /// In zh, this message translates to:
  /// **'食材（可选）'**
  String get ingredientOptional;

  /// No description provided for @texture.
  ///
  /// In zh, this message translates to:
  /// **'质地'**
  String get texture;

  /// No description provided for @color.
  ///
  /// In zh, this message translates to:
  /// **'颜色'**
  String get color;

  /// No description provided for @hasUrine.
  ///
  /// In zh, this message translates to:
  /// **'有尿'**
  String get hasUrine;

  /// No description provided for @hasUrineText.
  ///
  /// In zh, this message translates to:
  /// **'有尿'**
  String get hasUrineText;

  /// No description provided for @nutritionType.
  ///
  /// In zh, this message translates to:
  /// **'营养品类型'**
  String get nutritionType;

  /// No description provided for @babyManagement.
  ///
  /// In zh, this message translates to:
  /// **'宝宝管理'**
  String get babyManagement;

  /// No description provided for @noBabyInfo.
  ///
  /// In zh, this message translates to:
  /// **'还没有宝宝信息'**
  String get noBabyInfo;

  /// No description provided for @deleteBaby.
  ///
  /// In zh, this message translates to:
  /// **'删除宝宝'**
  String get deleteBaby;

  /// No description provided for @deleteBabyConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「{name}」的所有信息吗？此操作不可恢复。'**
  String deleteBabyConfirm(String name);

  /// No description provided for @editBaby.
  ///
  /// In zh, this message translates to:
  /// **'编辑宝宝'**
  String get editBaby;

  /// No description provided for @addBaby.
  ///
  /// In zh, this message translates to:
  /// **'添加宝宝'**
  String get addBaby;

  /// No description provided for @babyName.
  ///
  /// In zh, this message translates to:
  /// **'宝宝姓名'**
  String get babyName;

  /// No description provided for @babyNameHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入宝宝姓名'**
  String get babyNameHint;

  /// No description provided for @babyNameRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入宝宝姓名'**
  String get babyNameRequired;

  /// No description provided for @gender.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get gender;

  /// No description provided for @birthDate.
  ///
  /// In zh, this message translates to:
  /// **'出生日期'**
  String get birthDate;

  /// No description provided for @optional.
  ///
  /// In zh, this message translates to:
  /// **'可选'**
  String get optional;

  /// No description provided for @invalidNumber.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效数字'**
  String get invalidNumber;

  /// No description provided for @sectionTheme.
  ///
  /// In zh, this message translates to:
  /// **'主题风格'**
  String get sectionTheme;

  /// No description provided for @sectionBabyManagement.
  ///
  /// In zh, this message translates to:
  /// **'宝宝管理'**
  String get sectionBabyManagement;

  /// No description provided for @sectionAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get sectionAbout;

  /// No description provided for @addBabyHint.
  ///
  /// In zh, this message translates to:
  /// **'点击右下角 + 添加宝宝'**
  String get addBabyHint;

  /// No description provided for @appName.
  ///
  /// In zh, this message translates to:
  /// **'育婴宝'**
  String get appName;

  /// No description provided for @version.
  ///
  /// In zh, this message translates to:
  /// **'版本 {version}'**
  String version(String version);

  /// No description provided for @openSource.
  ///
  /// In zh, this message translates to:
  /// **'开源地址'**
  String get openSource;

  /// No description provided for @feedingVolumeTitle.
  ///
  /// In zh, this message translates to:
  /// **'喂养量（ml）'**
  String get feedingVolumeTitle;

  /// No description provided for @whoWeightTitle.
  ///
  /// In zh, this message translates to:
  /// **'WHO 体重曲线（kg）'**
  String get whoWeightTitle;

  /// No description provided for @whoHeightTitle.
  ///
  /// In zh, this message translates to:
  /// **'WHO 身高曲线（cm）'**
  String get whoHeightTitle;

  /// No description provided for @diaperCountTitle.
  ///
  /// In zh, this message translates to:
  /// **'换尿布次数'**
  String get diaperCountTitle;

  /// No description provided for @weight.
  ///
  /// In zh, this message translates to:
  /// **'体重'**
  String get weight;

  /// No description provided for @height.
  ///
  /// In zh, this message translates to:
  /// **'身高'**
  String get height;

  /// No description provided for @noReferenceData.
  ///
  /// In zh, this message translates to:
  /// **'暂无参考数据'**
  String get noReferenceData;

  /// No description provided for @noFeedingData.
  ///
  /// In zh, this message translates to:
  /// **'暂无喂养数据'**
  String get noFeedingData;

  /// No description provided for @noDiaperData.
  ///
  /// In zh, this message translates to:
  /// **'暂无换尿布数据'**
  String get noDiaperData;

  /// No description provided for @baby.
  ///
  /// In zh, this message translates to:
  /// **'宝宝'**
  String get baby;

  /// No description provided for @loadError.
  ///
  /// In zh, this message translates to:
  /// **'加载失败: {error}'**
  String loadError(String error);

  /// No description provided for @monthLabel.
  ///
  /// In zh, this message translates to:
  /// **'{month}月'**
  String monthLabel(String month);

  /// No description provided for @timeRangeToday.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get timeRangeToday;

  /// No description provided for @timeRangeWeek.
  ///
  /// In zh, this message translates to:
  /// **'近7天'**
  String get timeRangeWeek;

  /// No description provided for @timeRangeMonth.
  ///
  /// In zh, this message translates to:
  /// **'近30天'**
  String get timeRangeMonth;

  /// No description provided for @prevDay.
  ///
  /// In zh, this message translates to:
  /// **'前一天'**
  String get prevDay;

  /// No description provided for @nextDay.
  ///
  /// In zh, this message translates to:
  /// **'后一天'**
  String get nextDay;

  /// No description provided for @confirmDelete.
  ///
  /// In zh, this message translates to:
  /// **'确认删除'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteRecord.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这条记录吗？此操作不可恢复。'**
  String get confirmDeleteRecord;

  /// No description provided for @knowledgeTitle.
  ///
  /// In zh, this message translates to:
  /// **'育儿知识'**
  String get knowledgeTitle;

  /// No description provided for @knowledgeAll.
  ///
  /// In zh, this message translates to:
  /// **'全部'**
  String get knowledgeAll;

  /// No description provided for @knowledgeCategoryFeeding.
  ///
  /// In zh, this message translates to:
  /// **'喂养'**
  String get knowledgeCategoryFeeding;

  /// No description provided for @knowledgeCategoryHealth.
  ///
  /// In zh, this message translates to:
  /// **'健康'**
  String get knowledgeCategoryHealth;

  /// No description provided for @knowledgeCategoryDevelopment.
  ///
  /// In zh, this message translates to:
  /// **'发育'**
  String get knowledgeCategoryDevelopment;

  /// No description provided for @knowledgeCategorySolid.
  ///
  /// In zh, this message translates to:
  /// **'辅食'**
  String get knowledgeCategorySolid;

  /// No description provided for @noArticles.
  ///
  /// In zh, this message translates to:
  /// **'暂无相关文章'**
  String get noArticles;

  /// No description provided for @feedingReminder.
  ///
  /// In zh, this message translates to:
  /// **'喂奶提醒'**
  String get feedingReminder;

  /// No description provided for @feedingReminderDesc.
  ///
  /// In zh, this message translates to:
  /// **'设置固定间隔提醒喂奶'**
  String get feedingReminderDesc;

  /// No description provided for @feedingReminderEnabled.
  ///
  /// In zh, this message translates to:
  /// **'开启提醒'**
  String get feedingReminderEnabled;

  /// No description provided for @feedingIntervalHours.
  ///
  /// In zh, this message translates to:
  /// **'间隔时间（小时）'**
  String get feedingIntervalHours;

  /// No description provided for @feedingReminderNotification.
  ///
  /// In zh, this message translates to:
  /// **'该给宝宝喂奶了！'**
  String get feedingReminderNotification;

  /// No description provided for @feedingReminderTitle.
  ///
  /// In zh, this message translates to:
  /// **'喂奶提醒'**
  String get feedingReminderTitle;

  /// No description provided for @sectionLanguage.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get sectionLanguage;

  /// No description provided for @languageFollowSystem.
  ///
  /// In zh, this message translates to:
  /// **'跟随系统'**
  String get languageFollowSystem;

  /// No description provided for @language.
  ///
  /// In zh, this message translates to:
  /// **'语言'**
  String get language;

  /// No description provided for @languageZh.
  ///
  /// In zh, this message translates to:
  /// **'中文'**
  String get languageZh;

  /// No description provided for @languageEn.
  ///
  /// In zh, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @languageJa.
  ///
  /// In zh, this message translates to:
  /// **'日本語'**
  String get languageJa;

  /// No description provided for @languageKo.
  ///
  /// In zh, this message translates to:
  /// **'한국어'**
  String get languageKo;

  /// No description provided for @birthHeightLabel.
  ///
  /// In zh, this message translates to:
  /// **'出生身高 (cm)'**
  String get birthHeightLabel;

  /// No description provided for @birthWeightLabel.
  ///
  /// In zh, this message translates to:
  /// **'出生体重 (kg)'**
  String get birthWeightLabel;

  /// No description provided for @birthPrefix.
  ///
  /// In zh, this message translates to:
  /// **'出生'**
  String get birthPrefix;

  /// No description provided for @monthsAgo.
  ///
  /// In zh, this message translates to:
  /// **'{months} 个月'**
  String monthsAgo(String months);

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get saveFailed;

  /// No description provided for @loadFailure.
  ///
  /// In zh, this message translates to:
  /// **'加载失败'**
  String get loadFailure;

  /// No description provided for @tapToAddBaby.
  ///
  /// In zh, this message translates to:
  /// **'点击右下角 + 添加宝宝'**
  String get tapToAddBaby;

  /// No description provided for @confirmDeleteBaby.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「{name}」的所有信息吗？此操作不可恢复。'**
  String confirmDeleteBaby(String name);

  /// No description provided for @searchArticles.
  ///
  /// In zh, this message translates to:
  /// **'搜索文章...'**
  String get searchArticles;

  /// No description provided for @ageRange0To6.
  ///
  /// In zh, this message translates to:
  /// **'0-6月'**
  String get ageRange0To6;

  /// No description provided for @ageRange6To12.
  ///
  /// In zh, this message translates to:
  /// **'6-12月'**
  String get ageRange6To12;

  /// No description provided for @ageRange12To24.
  ///
  /// In zh, this message translates to:
  /// **'12-24月'**
  String get ageRange12To24;

  /// No description provided for @amountMl.
  ///
  /// In zh, this message translates to:
  /// **'量（ml）'**
  String get amountMl;

  /// No description provided for @heightCm.
  ///
  /// In zh, this message translates to:
  /// **'身高（cm）'**
  String get heightCm;

  /// No description provided for @weightKg.
  ///
  /// In zh, this message translates to:
  /// **'体重（kg）'**
  String get weightKg;

  /// No description provided for @recordLoadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败：{error}'**
  String recordLoadFailed(String error);

  /// No description provided for @timesPerDay.
  ///
  /// In zh, this message translates to:
  /// **'{count}次'**
  String timesPerDay(int count);

  /// No description provided for @diaperChangesCount.
  ///
  /// In zh, this message translates to:
  /// **'{count}次换尿布'**
  String diaperChangesCount(int count);

  /// No description provided for @durationMinutesUnit.
  ///
  /// In zh, this message translates to:
  /// **'分钟'**
  String get durationMinutesUnit;

  /// No description provided for @amountMlUnit.
  ///
  /// In zh, this message translates to:
  /// **'ml'**
  String get amountMlUnit;

  /// No description provided for @heightCmUnit.
  ///
  /// In zh, this message translates to:
  /// **'cm'**
  String get heightCmUnit;

  /// No description provided for @weightKgUnit.
  ///
  /// In zh, this message translates to:
  /// **'kg'**
  String get weightKgUnit;

  /// No description provided for @deleteRecordConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这条{recordType}记录吗？'**
  String deleteRecordConfirm(Object recordType);
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'ja':
      return SJa();
    case 'ko':
      return SKo();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
      'S.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
