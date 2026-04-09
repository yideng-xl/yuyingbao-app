import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Skin definitions ───

enum AppSkin {
  warmPink('温馨粉', '柔粉色调，温馨甜蜜'),
  oceanBlue('清新蓝', '蓝色系，清爽沉稳'),
  natureGreen('自然绿', '绿色系，清新自然'),
  sunnyOrange('暖阳橙', '暖橙色调，活力满满');

  final String label;
  final String description;
  const AppSkin(this.label, this.description);
}

class SkinColors {
  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color background;
  final Color border;
  final Color shadowTint;
  final Color selectedBg;
  final List<Color> avatarGradientBoy;
  final List<Color> avatarGradientGirl;

  const SkinColors({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.background,
    required this.border,
    required this.shadowTint,
    required this.selectedBg,
    required this.avatarGradientBoy,
    required this.avatarGradientGirl,
  });
}

// ─── Provider ───

final appSkinProvider = StateProvider<AppSkin>((ref) => AppSkin.warmPink);

// ─── Theme class ───

class AppTheme {
  AppTheme._();

  // Shared constants
  static const cardBg = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF0F172A);
  static const textMuted = Color(0xFF64748B);

  // Record type colors (shared across all skins)
  static const breastfeedingColor = Color(0xFFFF8A65);
  static const bottleColor = Color(0xFF4FC3F7);
  static const solidColor = Color(0xFF81C784);
  static const diaperColor = Color(0xFFBA68C8);
  static const growthColor = Color(0xFFFFD54F);
  static const waterColor = Color(0xFF4DD0E1);
  static const nutritionColor = Color(0xFFE57373);

  static const _skins = <AppSkin, SkinColors>{
    AppSkin.warmPink: SkinColors(
      primary: Color(0xFFEC4899),
      primaryContainer: Color(0xFFFCE7F3),
      secondary: Color(0xFF0284C7),
      secondaryContainer: Color(0xFFE0F2FE),
      background: Color(0xFFFDF2F8),
      border: Color(0xFFFCE9F2),
      shadowTint: Color(0x12EC4899),
      selectedBg: Color(0xFFFCE7F3),
      avatarGradientBoy: [Color(0xFF81D4FA), Color(0xFF4FC3F7)],
      avatarGradientGirl: [Color(0xFFF472B6), Color(0xFFEC4899)],
    ),
    AppSkin.oceanBlue: SkinColors(
      primary: Color(0xFF3B82F6),
      primaryContainer: Color(0xFFDBEAFE),
      secondary: Color(0xFF0EA5E9),
      secondaryContainer: Color(0xFFE0F2FE),
      background: Color(0xFFF0F7FF),
      border: Color(0xFFDBEAFE),
      shadowTint: Color(0x123B82F6),
      selectedBg: Color(0xFFDBEAFE),
      avatarGradientBoy: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
      avatarGradientGirl: [Color(0xFFF9A8D4), Color(0xFFEC4899)],
    ),
    AppSkin.natureGreen: SkinColors(
      primary: Color(0xFF10B981),
      primaryContainer: Color(0xFFD1FAE5),
      secondary: Color(0xFF059669),
      secondaryContainer: Color(0xFFA7F3D0),
      background: Color(0xFFF0FDF4),
      border: Color(0xFFD1FAE5),
      shadowTint: Color(0x1210B981),
      selectedBg: Color(0xFFD1FAE5),
      avatarGradientBoy: [Color(0xFF6EE7B7), Color(0xFF34D399)],
      avatarGradientGirl: [Color(0xFFFDA4AF), Color(0xFFFB7185)],
    ),
    AppSkin.sunnyOrange: SkinColors(
      primary: Color(0xFFF97316),
      primaryContainer: Color(0xFFFFF7ED),
      secondary: Color(0xFFEA580C),
      secondaryContainer: Color(0xFFFFEDD5),
      background: Color(0xFFFFF8F0),
      border: Color(0xFFFED7AA),
      shadowTint: Color(0x12F97316),
      selectedBg: Color(0xFFFFF7ED),
      avatarGradientBoy: [Color(0xFF93C5FD), Color(0xFF60A5FA)],
      avatarGradientGirl: [Color(0xFFFDBA74), Color(0xFFF97316)],
    ),
  };

  static SkinColors colorsFor(AppSkin skin) => _skins[skin]!;

  static SkinColors get currentColors => _skins[AppSkin.warmPink]!;

  static ThemeData themeFor(AppSkin skin) {
    final c = _skins[skin]!;

    return FlexThemeData.light(
      colors: FlexSchemeColor(
        primary: c.primary,
        primaryContainer: c.primaryContainer,
        secondary: c.secondary,
        secondaryContainer: c.secondaryContainer,
        tertiary: const Color(0xFF10B981),
        tertiaryContainer: const Color(0xFFD1FAE5),
      ),
      scaffoldBackground: c.background,
      useMaterial3: true,
      subThemesData: const FlexSubThemesData(
        cardRadius: 20.0,
        chipRadius: 24.0,
        inputDecoratorRadius: 16.0,
        dialogRadius: 24.0,
        bottomSheetRadius: 24.0,
        fabRadius: 20.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurfaceVariant,
        navigationBarIndicatorSchemeColor: SchemeColor.primaryContainer,
        navigationBarSelectedIconSchemeColor: SchemeColor.primary,
        cardElevation: 0,
        elevatedButtonRadius: 16.0,
        filledButtonRadius: 16.0,
        outlinedButtonRadius: 16.0,
        textButtonRadius: 12.0,
      ),
    ).copyWith(
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: c.border, width: 1.5),
        ),
        color: cardBg,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textMuted),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: c.background,
        foregroundColor: textPrimary,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1),
    );
  }

  /// Claymorphism card decoration — uses skin colors
  static BoxDecoration clayCard(SkinColors c, {Color? color}) {
    return BoxDecoration(
      color: color ?? cardBg,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: c.border, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: c.shadowTint,
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
        const BoxShadow(
          color: Color(0x08000000),
          offset: Offset(0, 1),
          blurRadius: 3,
        ),
      ],
    );
  }

  /// Selected card decoration
  static BoxDecoration clayCardSelected(SkinColors c) {
    return BoxDecoration(
      color: c.selectedBg,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: c.primary.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: c.shadowTint,
          offset: const Offset(0, 4),
          blurRadius: 16,
        ),
      ],
    );
  }
}
