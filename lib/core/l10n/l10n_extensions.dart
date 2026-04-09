import 'package:yuyingbao/l10n/generated/app_localizations.dart';
import '../../features/statistics/providers/statistics_providers.dart';
import '../constants/enums.dart';
import '../theme/app_theme.dart';

/// Localized label extensions for all enums.

extension RecordTypeL10n on RecordType {
  String l10n(S s) {
    switch (this) {
      case RecordType.breastfeeding:
        return s.recordTypeBreastfeeding;
      case RecordType.bottle:
        return s.recordTypeBottle;
      case RecordType.formula:
        return s.recordTypeFormula;
      case RecordType.solid:
        return s.recordTypeSolid;
      case RecordType.diaper:
        return s.recordTypeDiaper;
      case RecordType.growth:
        return s.recordTypeGrowth;
      case RecordType.water:
        return s.recordTypeWater;
      case RecordType.nutrition:
        return s.recordTypeNutrition;
    }
  }
}

extension BreastfeedingSideL10n on BreastfeedingSide {
  String l10n(S s) {
    switch (this) {
      case BreastfeedingSide.left:
        return s.breastfeedingSideLeft;
      case BreastfeedingSide.right:
        return s.breastfeedingSideRight;
      case BreastfeedingSide.both:
        return s.breastfeedingSideBoth;
    }
  }
}

extension SolidTypeL10n on SolidType {
  String l10n(S s) {
    switch (this) {
      case SolidType.riceCereal:
        return s.solidTypeRiceCereal;
      case SolidType.vegetablePuree:
        return s.solidTypeVegetablePuree;
      case SolidType.fruitPuree:
        return s.solidTypeFruitPuree;
      case SolidType.meatPuree:
        return s.solidTypeMeatPuree;
      case SolidType.eggYolk:
        return s.solidTypeEggYolk;
      case SolidType.other:
        return s.solidTypeOther;
    }
  }
}

extension DiaperTextureL10n on DiaperTexture {
  String l10n(S s) {
    switch (this) {
      case DiaperTexture.watery:
        return s.diaperTextureWatery;
      case DiaperTexture.soft:
        return s.diaperTextureSoft;
      case DiaperTexture.normal:
        return s.diaperTextureNormal;
      case DiaperTexture.hard:
        return s.diaperTextureHard;
    }
  }
}

extension DiaperColorL10n on DiaperColor {
  String l10n(S s) {
    switch (this) {
      case DiaperColor.yellow:
        return s.diaperColorYellow;
      case DiaperColor.green:
        return s.diaperColorGreen;
      case DiaperColor.brown:
        return s.diaperColorBrown;
      case DiaperColor.black:
        return s.diaperColorBlack;
    }
  }
}

extension GenderL10n on Gender {
  String l10n(S s) {
    switch (this) {
      case Gender.male:
        return s.genderMale;
      case Gender.female:
        return s.genderFemale;
    }
  }
}

extension AppSkinL10n on AppSkin {
  String l10nLabel(S s) {
    switch (this) {
      case AppSkin.warmPink:
        return s.skinWarmPink;
      case AppSkin.oceanBlue:
        return s.skinOceanBlue;
      case AppSkin.natureGreen:
        return s.skinNatureGreen;
      case AppSkin.sunnyOrange:
        return s.skinSunnyOrange;
    }
  }

  String l10nDescription(S s) {
    switch (this) {
      case AppSkin.warmPink:
        return s.skinWarmPinkDesc;
      case AppSkin.oceanBlue:
        return s.skinOceanBlueDesc;
      case AppSkin.natureGreen:
        return s.skinNatureGreenDesc;
      case AppSkin.sunnyOrange:
        return s.skinSunnyOrangeDesc;
    }
  }
}

extension StatsTimeRangeL10n on StatsTimeRange {
  String l10n(S s) {
    switch (this) {
      case StatsTimeRange.today:
        return s.timeRangeToday;
      case StatsTimeRange.week:
        return s.timeRangeWeek;
      case StatsTimeRange.month:
        return s.timeRangeMonth;
    }
  }
}
