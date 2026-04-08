import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return FlexThemeData.light(
      colors: const FlexSchemeColor(
        primary: Color(0xFFFFB74D),
        primaryContainer: Color(0xFFFFE0B2),
        secondary: Color(0xFF81D4FA),
        secondaryContainer: Color(0xFFB3E5FC),
        tertiary: Color(0xFFA5D6A7),
        tertiaryContainer: Color(0xFFC8E6C9),
      ),
      scaffoldBackground: const Color(0xFFFFF8F0),
      useMaterial3: true,
      subThemesData: const FlexSubThemesData(
        cardRadius: 16.0,
        chipRadius: 20.0,
        inputDecoratorRadius: 12.0,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        bottomNavigationBarUnselectedLabelSchemeColor:
            SchemeColor.onSurfaceVariant,
      ),
    );
  }
}
