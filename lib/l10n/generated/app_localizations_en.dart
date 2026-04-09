// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'YuyingBao';

  @override
  String get navHome => 'Home';

  @override
  String get navRecords => 'Records';

  @override
  String get navStatistics => 'Stats';

  @override
  String get navKnowledge => 'Knowledge';

  @override
  String get navSettings => 'Settings';

  @override
  String get switchBaby => 'Switch Baby';

  @override
  String get todayOverview => 'Today\'s Overview';

  @override
  String get feedingCount => 'Feedings';

  @override
  String get feedingCountUnit => 'times';

  @override
  String get milkVolume => 'Milk';

  @override
  String get diaperCount => 'Diapers';

  @override
  String get diaperCountUnit => 'times';

  @override
  String get waterVolume => 'Water';

  @override
  String get recentRecords => 'Recent Records';

  @override
  String get noRecordsYet => 'No records yet, start adding!';

  @override
  String get noBabyYet => 'No baby added yet, please add a baby first';

  @override
  String get addRecord => 'Add Record';

  @override
  String get addBabyFirst => 'Please add a baby first';

  @override
  String get addBabyFirstInfo => 'Please add baby info first';

  @override
  String get recordTypeBreastfeeding => 'Breastfeeding';

  @override
  String get recordTypeBottle => 'Bottle Feed';

  @override
  String get recordTypeFormula => 'Formula';

  @override
  String get recordTypeSolid => 'Solid Food';

  @override
  String get recordTypeDiaper => 'Diaper';

  @override
  String get recordTypeGrowth => 'Growth';

  @override
  String get recordTypeWater => 'Water';

  @override
  String get recordTypeNutrition => 'Supplement';

  @override
  String get breastfeedingSideLeft => 'Left';

  @override
  String get breastfeedingSideRight => 'Right';

  @override
  String get breastfeedingSideBoth => 'Both';

  @override
  String get solidTypeRiceCereal => 'Rice Cereal';

  @override
  String get solidTypeVegetablePuree => 'Veggie Puree';

  @override
  String get solidTypeFruitPuree => 'Fruit Puree';

  @override
  String get solidTypeMeatPuree => 'Meat Puree';

  @override
  String get solidTypeEggYolk => 'Egg Yolk';

  @override
  String get solidTypeOther => 'Other';

  @override
  String get diaperTextureWatery => 'Watery';

  @override
  String get diaperTextureSoft => 'Soft';

  @override
  String get diaperTextureNormal => 'Normal';

  @override
  String get diaperTextureHard => 'Hard';

  @override
  String get diaperColorYellow => 'Yellow';

  @override
  String get diaperColorGreen => 'Green';

  @override
  String get diaperColorBrown => 'Brown';

  @override
  String get diaperColorBlack => 'Black';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderBoy => 'Boy';

  @override
  String get genderGirl => 'Girl';

  @override
  String get skinWarmPink => 'Warm Pink';

  @override
  String get skinWarmPinkDesc => 'Sweet and warm pink tone';

  @override
  String get skinOceanBlue => 'Ocean Blue';

  @override
  String get skinOceanBlueDesc => 'Clean and calm blue';

  @override
  String get skinNatureGreen => 'Nature Green';

  @override
  String get skinNatureGreenDesc => 'Fresh and natural green';

  @override
  String get skinSunnyOrange => 'Sunny Orange';

  @override
  String get skinSunnyOrangeDesc => 'Energetic and warm orange';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get dayBeforeYesterday => '2 days ago';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get recordType => 'Record Type';

  @override
  String get time => 'Time';

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String get breastfeedingSide => 'Feeding Side';

  @override
  String get durationMinutes => 'Duration (min)';

  @override
  String get solidType => 'Solid Food Type';

  @override
  String get ingredientOptional => 'Ingredients (optional)';

  @override
  String get texture => 'Texture';

  @override
  String get color => 'Color';

  @override
  String get hasUrine => 'Has Urine';

  @override
  String get hasUrineText => 'Wet';

  @override
  String get nutritionType => 'Supplement Type';

  @override
  String get babyManagement => 'Baby Management';

  @override
  String get noBabyInfo => 'No baby info yet';

  @override
  String get deleteBaby => 'Delete Baby';

  @override
  String deleteBabyConfirm(String name) {
    return 'Are you sure you want to delete all info for \"$name\"? This cannot be undone.';
  }

  @override
  String get editBaby => 'Edit Baby';

  @override
  String get addBaby => 'Add Baby';

  @override
  String get babyName => 'Baby Name';

  @override
  String get babyNameHint => 'Enter baby\'s name';

  @override
  String get babyNameRequired => 'Please enter baby\'s name';

  @override
  String get gender => 'Gender';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get optional => 'Optional';

  @override
  String get invalidNumber => 'Please enter a valid number';

  @override
  String get sectionTheme => 'Theme';

  @override
  String get sectionBabyManagement => 'Baby Management';

  @override
  String get sectionAbout => 'About';

  @override
  String get addBabyHint => 'Tap + to add a baby';

  @override
  String get appName => 'YuyingBao';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get openSource => 'Source Code';

  @override
  String get feedingVolumeTitle => 'Feeding Volume (ml)';

  @override
  String get whoWeightTitle => 'WHO Weight Curve (kg)';

  @override
  String get whoHeightTitle => 'WHO Height Curve (cm)';

  @override
  String get diaperCountTitle => 'Diaper Changes';

  @override
  String get weight => 'Weight';

  @override
  String get height => 'Height';

  @override
  String get noReferenceData => 'No reference data';

  @override
  String get noFeedingData => 'No feeding data';

  @override
  String get noDiaperData => 'No diaper data';

  @override
  String get baby => 'Baby';

  @override
  String loadError(String error) {
    return 'Load failed: $error';
  }

  @override
  String monthLabel(String month) {
    return '${month}m';
  }

  @override
  String get timeRangeToday => 'Today';

  @override
  String get timeRangeWeek => '7 Days';

  @override
  String get timeRangeMonth => '30 Days';

  @override
  String get prevDay => 'Previous day';

  @override
  String get nextDay => 'Next day';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get confirmDeleteRecord =>
      'Are you sure you want to delete this record? This cannot be undone.';

  @override
  String get knowledgeTitle => 'Knowledge Base';

  @override
  String get knowledgeAll => 'All';

  @override
  String get knowledgeCategoryFeeding => 'Feeding';

  @override
  String get knowledgeCategoryHealth => 'Health';

  @override
  String get knowledgeCategoryDevelopment => 'Development';

  @override
  String get knowledgeCategorySolid => 'Solid Food';

  @override
  String get noArticles => 'No articles found';

  @override
  String get feedingReminder => 'Feeding Reminder';

  @override
  String get feedingReminderDesc => 'Set a fixed interval feeding reminder';

  @override
  String get feedingReminderEnabled => 'Enable Reminder';

  @override
  String get feedingIntervalHours => 'Interval (hours)';

  @override
  String get feedingReminderNotification => 'Time to feed the baby!';

  @override
  String get feedingReminderTitle => 'Feeding Reminder';

  @override
  String get sectionLanguage => 'Language';

  @override
  String get languageFollowSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get languageZh => '中文';

  @override
  String get languageEn => 'English';

  @override
  String get languageJa => '日本語';

  @override
  String get languageKo => '한국어';

  @override
  String get birthHeightLabel => 'Birth Height (cm)';

  @override
  String get birthWeightLabel => 'Birth Weight (kg)';

  @override
  String get birthPrefix => 'Born';

  @override
  String monthsAgo(String months) {
    return '$months months';
  }

  @override
  String get saveFailed => 'Save failed';

  @override
  String get loadFailure => 'Load failed';

  @override
  String get tapToAddBaby => 'Tap + to add a baby';

  @override
  String confirmDeleteBaby(String name) {
    return 'Are you sure you want to delete all info for \"$name\"? This cannot be undone.';
  }

  @override
  String get searchArticles => 'Search articles...';

  @override
  String get ageRange0To6 => '0-6 months';

  @override
  String get ageRange6To12 => '6-12 months';

  @override
  String get ageRange12To24 => '12-24 months';

  @override
  String get amountMl => 'Amount (ml)';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String recordLoadFailed(String error) {
    return 'Failed to load: $error';
  }

  @override
  String timesPerDay(int count) {
    return '$count times';
  }

  @override
  String diaperChangesCount(int count) {
    return '$count diaper changes';
  }

  @override
  String get durationMinutesUnit => 'min';

  @override
  String get amountMlUnit => 'ml';

  @override
  String get heightCmUnit => 'cm';

  @override
  String get weightKgUnit => 'kg';

  @override
  String deleteRecordConfirm(Object recordType) {
    return 'Are you sure you want to delete this $recordType record?';
  }
}
