import 'package:flutter/material.dart';
import 'package:giggle/presentation/themes/constants/palette.dart';

class TextStyles {
  static String fontFamily = 'urbanist';

  static TextStyle h2Black = TextStyle(
    color: Palette.black,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.1,
  );

  static TextStyle h2Primary({required Color color}) => TextStyle(
        color: color,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: 1.1,
      );

  static TextStyle h3PrimaryBold({required Color color}) => TextStyle(
        color: color,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle h3Black = TextStyle(
    color: Palette.black,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.3181818181818181,
  );

  static TextStyle h4BoldDarkGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.3333333333333333,
  );

  static TextStyle h4NormalDarkGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.3333333333333333,
  );

  static TextStyle h4NormalGreyCentered = TextStyle(
    color: Palette.grey500,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.3333333333333333,
  );

  static TextStyle h4NormalBlack = TextStyle(
    color: Palette.black,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.3333333333333333,
  );

  static TextStyle lauftextBoldError = TextStyle(
    color: Palette.error,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle lauftextBoldBlack = TextStyle(
    color: Palette.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle lauftextNormalGreyMain = TextStyle(
    color: Palette.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.4375,
  );

  static TextStyle lauftextNormalPrimary = TextStyle(
    color: Palette.primary,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle lauftextNormalGreyCentered = TextStyle(
    color: Palette.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    height: 1.4375,
  );

  static TextStyle lauftextNormalBlack = TextStyle(
    color: Palette.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle lauftextNormalGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle lauftextNormalDarkGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle paragraphBoldBlack = TextStyle(
    color: Palette.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle paragraphNormalGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.4375,
  );

  static TextStyle bodyTextNormalBlack = TextStyle(
    color: Palette.grey700,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    height: 1.3333333333333333,
  );

  static TextStyle smallGrey = TextStyle(
    color: Palette.grey500,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.2142857142857142,
  );

  static TextStyle captionNormalBlack = TextStyle(
    color: Palette.grey700,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.3333333333333333,
  );

  static TextStyle lauftextTinyRegularDarkBlack = TextStyle(
    color: Palette.grey700,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  /// New Styles
  static TextStyle header1({Color? color, FontWeight? fontWeight}) => TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 42,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: 1.1904761904761905,
      );

  static TextStyle header2({Color? color, FontWeight? fontWeight}) => TextStyle(
        color: color ?? Palette.grey700,
        fontSize: 30,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
        height: 1.1,
      );

  static TextStyle header3({Color? color, FontWeight? fontWeight}) => TextStyle(
        color: color ?? Palette.grey700,
        fontSize: 22,
        height: 1.3181818181818181,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle header4Bold({
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 18,
        height: height ?? 1.3333333333333333,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle header4Regular({Color? color, bool isTextBold = false}) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 18,
        height: 1.3333333333333333,
        fontWeight: isTextBold ? FontWeight.w700 : FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle paragraphBold({
    Color? color,
    double? fontSize = 16,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: fontSize,
        decoration: textDecoration,
        height: 1.4375,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle paragraphRegular({
    Color? color,
    FontWeight? fontWeight,
    double? height = 1.4375,
    TextDecoration? textDecoration,
    double fontSize = 16,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: fontSize,
        decoration: textDecoration,
        height: height ?? 1.4375,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle smallBold({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 14,
        height: 1.3333333333333333,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle smallRegular({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 14,
        height: 1,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle tinyBold({
    Color? color,
    FontWeight? fontWeight,
    double? textSize = 10,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: textSize,
        fontWeight: fontWeight ?? FontWeight.w700,
        fontStyle: FontStyle.normal,
      );

  static TextStyle tinyRegular({
    Color? color,
    FontWeight? fontWeight,
    double? textSize = 10,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: textSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle textFieldLabel({
    Color? color,
    FontWeight? fontWeight,
    bool isTextBold = false,
  }) =>
      TextStyle(
        color: color ?? Palette.grey500,
        fontSize: 18,
        height: 1.3333333333333333,
        fontWeight: isTextBold ? FontWeight.w700 : FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle textFieldHint({Color? color, FontWeight? fontWeight}) =>
      TextStyle(
        color: color ?? Palette.grey50,
        fontSize: 14,
        height: 1.3333333333333333,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
      );

  static TextStyle buttonPrimary({Color? textColor, FontWeight? fontWeight}) =>
      header4Bold(color: textColor, fontWeight: fontWeight);

  static TextStyle buttonSecondary({
    Color? textColor,
    bool isTextBold = false,
  }) =>
      paragraphRegular(
        color: textColor,
        fontWeight: isTextBold ? FontWeight.w700 : FontWeight.w400,
      );

  static TextStyle bottomMenuText({
    Color? textColor,
  }) =>
      TextStyle(
        color: textColor ?? Palette.primary,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
      );
}
