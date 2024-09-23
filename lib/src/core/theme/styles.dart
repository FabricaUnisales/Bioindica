import 'package:bioindica/src/core/ui_widgets/ui_widgets_lib.dart';
import 'package:flutter/material.dart';

class Styles {
  // Aplica cor nas Safe Areas
  // static SystemUiOverlayStyle get systemUiOverlay => const SystemUiOverlayStyle(
  //   statusBarColor: colorSecondary,
  //   systemNavigationBarColor: colorSecondary,
  //   systemNavigationBarDividerColor: colorSecondary,
  // );

  /// Define cores do tema
  static ThemeData setMaterial3Theme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: secondaryColor,
        secondary: secondaryColor,
        surface: primaryColor,
        onSurface: secondaryColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondaryColor,
        selectionColor: secondaryColor.withOpacity(0.3),
        selectionHandleColor: secondaryColor,
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: secondaryColor,
        headerForegroundColor: primaryColor,
        dividerColor: secondaryColor,
        dayForegroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return labelColor.withOpacity(0.3);
          return states.contains(WidgetState.selected) || states.contains(WidgetState.disabled)
              ? primaryColor
              : secondaryColor;
        }),
        dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? secondaryColor : primaryColor;
        }),
        todayForegroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? primaryColor : secondaryColor;
        }),
        todayBorder: BorderSide.none,
        todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? secondaryColor : primaryColor;
        }),
        confirmButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(secondaryColor)),
        cancelButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(failureColor)),
      ),
    );
    
  }
}