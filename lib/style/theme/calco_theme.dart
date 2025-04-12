import 'package:flutter/material.dart';

import '../colors/calco_colors.dart';
import '../typography/calco_text_styles.dart';

class CalcoTheme {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: CalcoTextStyles.displayLarge,
      displayMedium: CalcoTextStyles.displayMedium,
      displaySmall: CalcoTextStyles.displaySmall,
      headlineLarge: CalcoTextStyles.headlineLarge,
      headlineMedium: CalcoTextStyles.headlineMedium,
      headlineSmall: CalcoTextStyles.headlineSmall,
      titleLarge: CalcoTextStyles.titleLarge,
      titleMedium: CalcoTextStyles.titleMedium,
      titleSmall: CalcoTextStyles.titleSmall,
      bodyLarge: CalcoTextStyles.bodyLargeBold,
      bodyMedium: CalcoTextStyles.bodyLargeMedium,
      bodySmall: CalcoTextStyles.bodyLargeRegular,
      labelLarge: CalcoTextStyles.labelLarge,
      labelMedium: CalcoTextStyles.labelMedium,
      labelSmall: CalcoTextStyles.labelSmall,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      colorSchemeSeed: CalcoColors.primary.color,
      brightness: Brightness.light,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorSchemeSeed: CalcoColors.secondary.color,
      brightness: Brightness.dark,
      textTheme: _textTheme,
      useMaterial3: true,
    );
  }
}
