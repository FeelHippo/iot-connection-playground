import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giggle/presentation/themes/constants/palette.dart';
import 'package:giggle/presentation/themes/constants/spacings.dart';
import 'package:giggle/presentation/themes/constants/text_styles.dart';
import 'package:giggle/presentation/widgets/button_primary.dart';

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
        surface: Palette.white,
        onSurface: Palette.grey800,
        error: Palette.error,
        onError: Palette.white,
      ),
      primaryColor: Palette.primary,
      highlightColor: Palette.primary.withAlpha(Palette.opacity20),
      splashColor: Palette.primary.withAlpha(Palette.opacity20),
      fontFamily: TextStyles.fontFamily,
      scaffoldBackgroundColor: Palette.grey100,
      textTheme: TextTheme(
        labelLarge: TextStyles.paragraphRegular(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.primary,
          minimumSize: Size(
            88,
            ButtonPrimary.defaultHeight,
          ),
          elevation: 2,
        ),
      ),
      cupertinoOverrideTheme: cupertinoLightTheme(),
      cardTheme: CardTheme(
        elevation: 1,
        color: Palette.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Palette.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const _NoUnderlineInputBorder(),
        fillColor: Palette.white,
        contentPadding: const EdgeInsets.all(Spacings.medium),
        filled: true,
        hintStyle: TextStyles.header4Regular(color: Palette.grey50),
        floatingLabelStyle: TextStyles.smallRegular(),
        labelStyle: TextStyles.header4Regular(color: Palette.grey50),
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Palette.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyles.h3Black.copyWith(
          fontFamily: TextStyles.fontFamily,
        ),
        iconTheme: IconThemeData(color: Palette.secondary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        modalBackgroundColor: Palette.grey100,
      ),
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
