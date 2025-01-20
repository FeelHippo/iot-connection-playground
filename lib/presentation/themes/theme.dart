import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giggle/presentation/themes/constants/palette.dart';
import 'package:giggle/presentation/themes/constants/text_styles.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Palette.primary,
        onPrimary: Palette.white,
        secondary: Palette.secondary,
        onSecondary: Palette.white,
        surface: Palette.primary,
        onSurface: Palette.grey800,
        error: Palette.error,
        onError: Palette.white,
      ),
      primaryColor: Palette.primary,
      canvasColor: Palette.primary,
      highlightColor: Palette.primary.withAlpha(Palette.opacity20),
      splashColor: Palette.primary,
      fontFamily: TextStyles.fontFamily,
      scaffoldBackgroundColor: Palette.primary,
      cupertinoOverrideTheme: cupertinoLightTheme(),
    );
  }

  static CupertinoThemeData cupertinoLightTheme() {
    return CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: Palette.primary,
      primaryContrastingColor: Palette.primary,
      scaffoldBackgroundColor: Palette.grey100,
      barBackgroundColor: Palette.grey100,
      textTheme: CupertinoTextThemeData(
        primaryColor: Palette.grey800,
        dateTimePickerTextStyle: TextStyle(
          color: Palette.grey800,
          fontSize: 23,
        ),
      ),
    );
  }
}

class _NoUnderlineInputBorder extends UnderlineInputBorder {
  const _NoUnderlineInputBorder()
      : super(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        );
}
