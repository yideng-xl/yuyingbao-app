// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '育婴宝';

  @override
  String get navHome => '首页';

  @override
  String get navRecords => '记录';

  @override
  String get navStatistics => '统计';

  @override
  String get navKnowledge => '知识';

  @override
  String get navSettings => '设置';

  @override
  String get switchBaby => '切换宝宝';

  @override
  String get todayOverview => '今日概览';

  @override
  String get feedingCount => '喂奶';

  @override
  String get feedingCountUnit => '次';

  @override
  String get milkVolume => '奶量';

  @override
  String get diaperCount => '换尿布';

  @override
  String get diaperCountUnit => '次';

  @override
  String get waterVolume => '饮水';

  @override
  String get recentRecords => '最近记录';

  @override
  String get noRecordsYet => '还没有记录，快去添加吧';

  @override
  String get noBabyYet => '还没有添加宝宝，请先添加宝宝';

  @override
  String get addRecord => '添加记录';

  @override
  String get addBabyFirst => '请先添加宝宝';

  @override
  String get addBabyFirstInfo => '请先添加宝宝信息';

  @override
  String get recordTypeBreastfeeding => '母乳亲喂';

  @override
  String get recordTypeBottle => '瓶喂';

  @override
  String get recordTypeFormula => '配方奶';

  @override
  String get recordTypeSolid => '辅食';

  @override
  String get recordTypeDiaper => '尿布';

  @override
  String get recordTypeGrowth => '成长记录';

  @override
  String get recordTypeWater => '饮水';

  @override
  String get recordTypeNutrition => '营养补充';

  @override
  String get breastfeedingSideLeft => '左侧';

  @override
  String get breastfeedingSideRight => '右侧';

  @override
  String get breastfeedingSideBoth => '双侧';

  @override
  String get solidTypeRiceCereal => '米粉';

  @override
  String get solidTypeVegetablePuree => '蔬菜泥';

  @override
  String get solidTypeFruitPuree => '水果泥';

  @override
  String get solidTypeMeatPuree => '肉泥';

  @override
  String get solidTypeEggYolk => '蛋黄';

  @override
  String get solidTypeOther => '其他';

  @override
  String get diaperTextureWatery => '稀水样';

  @override
  String get diaperTextureSoft => '软便';

  @override
  String get diaperTextureNormal => '正常';

  @override
  String get diaperTextureHard => '干硬';

  @override
  String get diaperColorYellow => '黄色';

  @override
  String get diaperColorGreen => '绿色';

  @override
  String get diaperColorBrown => '褐色';

  @override
  String get diaperColorBlack => '黑色';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get genderBoy => '男宝';

  @override
  String get genderGirl => '女宝';

  @override
  String get skinWarmPink => '温馨粉';

  @override
  String get skinWarmPinkDesc => '柔粉色调，温馨甜蜜';

  @override
  String get skinOceanBlue => '清新蓝';

  @override
  String get skinOceanBlueDesc => '蓝色系，清爽沉稳';

  @override
  String get skinNatureGreen => '自然绿';

  @override
  String get skinNatureGreenDesc => '绿色系，清新自然';

  @override
  String get skinSunnyOrange => '暖阳橙';

  @override
  String get skinSunnyOrangeDesc => '暖橙色调，活力满满';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get dayBeforeYesterday => '前天';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get recordType => '记录类型';

  @override
  String get time => '时间';

  @override
  String get noteOptional => '备注（可选）';

  @override
  String get breastfeedingSide => '喂奶侧';

  @override
  String get durationMinutes => '时长（分钟）';

  @override
  String get solidType => '辅食类型';

  @override
  String get ingredientOptional => '食材（可选）';

  @override
  String get texture => '质地';

  @override
  String get color => '颜色';

  @override
  String get hasUrine => '有尿';

  @override
  String get hasUrineText => '有尿';

  @override
  String get nutritionType => '营养品类型';

  @override
  String get babyManagement => '宝宝管理';

  @override
  String get noBabyInfo => '还没有宝宝信息';

  @override
  String get deleteBaby => '删除宝宝';

  @override
  String deleteBabyConfirm(String name) {
    return '确定要删除「$name」的所有信息吗？此操作不可恢复。';
  }

  @override
  String get editBaby => '编辑宝宝';

  @override
  String get addBaby => '添加宝宝';

  @override
  String get babyName => '宝宝姓名';

  @override
  String get babyNameHint => '请输入宝宝姓名';

  @override
  String get babyNameRequired => '请输入宝宝姓名';

  @override
  String get gender => '性别';

  @override
  String get birthDate => '出生日期';

  @override
  String get optional => '可选';

  @override
  String get invalidNumber => '请输入有效数字';

  @override
  String get sectionTheme => '主题风格';

  @override
  String get sectionBabyManagement => '宝宝管理';

  @override
  String get sectionAbout => '关于';

  @override
  String get addBabyHint => '点击右下角 + 添加宝宝';

  @override
  String get appName => '育婴宝';

  @override
  String version(String version) {
    return '版本 $version';
  }

  @override
  String get openSource => '开源地址';

  @override
  String get feedingVolumeTitle => '喂养量（ml）';

  @override
  String get whoWeightTitle => 'WHO 体重曲线（kg）';

  @override
  String get whoHeightTitle => 'WHO 身高曲线（cm）';

  @override
  String get diaperCountTitle => '换尿布次数';

  @override
  String get weight => '体重';

  @override
  String get height => '身高';

  @override
  String get noReferenceData => '暂无参考数据';

  @override
  String get noFeedingData => '暂无喂养数据';

  @override
  String get noDiaperData => '暂无换尿布数据';

  @override
  String get baby => '宝宝';

  @override
  String loadError(String error) {
    return '加载失败: $error';
  }

  @override
  String monthLabel(String month) {
    return '$month月';
  }

  @override
  String get timeRangeToday => '今天';

  @override
  String get timeRangeWeek => '近7天';

  @override
  String get timeRangeMonth => '近30天';

  @override
  String get prevDay => '前一天';

  @override
  String get nextDay => '后一天';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get confirmDeleteRecord => '确定要删除这条记录吗？此操作不可恢复。';

  @override
  String get knowledgeTitle => '育儿知识';

  @override
  String get knowledgeAll => '全部';

  @override
  String get knowledgeCategoryFeeding => '喂养';

  @override
  String get knowledgeCategoryHealth => '健康';

  @override
  String get knowledgeCategoryDevelopment => '发育';

  @override
  String get knowledgeCategorySolid => '辅食';

  @override
  String get noArticles => '暂无相关文章';

  @override
  String get feedingReminder => '喂奶提醒';

  @override
  String get feedingReminderDesc => '设置固定间隔提醒喂奶';

  @override
  String get feedingReminderEnabled => '开启提醒';

  @override
  String get feedingIntervalHours => '间隔时间（小时）';

  @override
  String get feedingReminderNotification => '该给宝宝喂奶了！';

  @override
  String get feedingReminderTitle => '喂奶提醒';

  @override
  String get sectionLanguage => '语言';

  @override
  String get languageFollowSystem => '跟随系统';

  @override
  String get language => '语言';

  @override
  String get languageZh => '中文';

  @override
  String get languageEn => 'English';

  @override
  String get languageJa => '日本語';

  @override
  String get languageKo => '한국어';

  @override
  String get birthHeightLabel => '出生身高 (cm)';

  @override
  String get birthWeightLabel => '出生体重 (kg)';

  @override
  String get birthPrefix => '出生';

  @override
  String monthsAgo(String months) {
    return '$months 个月';
  }

  @override
  String get saveFailed => '保存失败';

  @override
  String get loadFailure => '加载失败';

  @override
  String get tapToAddBaby => '点击右下角 + 添加宝宝';

  @override
  String confirmDeleteBaby(String name) {
    return '确定要删除「$name」的所有信息吗？此操作不可恢复。';
  }

  @override
  String get searchArticles => '搜索文章...';

  @override
  String get ageRange0To6 => '0-6月';

  @override
  String get ageRange6To12 => '6-12月';

  @override
  String get ageRange12To24 => '12-24月';

  @override
  String get amountMl => '量（ml）';

  @override
  String get heightCm => '身高（cm）';

  @override
  String get weightKg => '体重（kg）';

  @override
  String recordLoadFailed(String error) {
    return '加载失败：$error';
  }

  @override
  String timesPerDay(int count) {
    return '$count次';
  }

  @override
  String diaperChangesCount(int count) {
    return '$count次换尿布';
  }

  @override
  String get durationMinutesUnit => '分钟';

  @override
  String get amountMlUnit => 'ml';

  @override
  String get heightCmUnit => 'cm';

  @override
  String get weightKgUnit => 'kg';

  @override
  String deleteRecordConfirm(Object recordType) {
    return '确定要删除这条$recordType记录吗？';
  }
}
