import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gulf_car_auction/settings/settings.dart';
import 'package:text_scroll/text_scroll.dart';

class AppTexts {
  AppTexts._();

  static Widget htmlText(
      {required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return HtmlWidget('''
$text
  ''',
        textStyle: TextStyle(
            color: color ?? AppColors.baseFontColor,
            decoration: textDecoration,
            fontSize: fontSize ?? Dimensions.mFontSize14,
            fontWeight: fontWeight,
            fontFamily: fontFamily));
  }

  static Widget autoScrollText(
      {required String text,
      Duration? pauseBetween,
      double? fontSize,
      FontWeight? fontWeight,
      bool selectable = false,
      TextAlign? textAlign,
      Color? color}) {
    return TextScroll(
      '$text                                     ',
      mode: TextScrollMode.endless,
      style: TextStyle(
        color: color ?? AppColors.baseFontColor,
        fontSize: fontSize ?? Dimensions.mFontSize12,
        fontWeight: fontWeight,
      ),
      pauseBetween: pauseBetween,
      velocity: const Velocity(pixelsPerSecond: Offset(40, 0)),
      textAlign: textAlign ?? TextAlign.right,
      selectable: selectable,
    );
  }

  static Widget richTextWithTap({
    VoidCallback? onTap,
    double? fontSize,
    required String normalText,
    required String tappableText,
    Color? normalTextColor,
    Color? tappableTextColor,
  }) {
    return RichText(
      text: TextSpan(
        text: '$normalText ',
        style: TextStyle(
            color: normalTextColor ?? AppColors.extraLightFontColor,
            fontSize: fontSize ?? Dimensions.mFontSize13,
            fontFamily: AppFonts.mulish),
        children: [
          TextSpan(
            text: tappableText,
            style: TextStyle(
                color: tappableTextColor ?? AppColors.blue,
                fontWeight: FontWeight.w400),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }

  static Widget extraLargeText(
      {int? maxLine,
      TextAlign? textAlign,
      TextOverflow? overflow,
      required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColors.baseFontColor,
          decoration: textDecoration,
          fontSize: fontSize ?? Dimensions.mFontSize26,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }

  static Widget largeText(
      {int? maxLine,
      TextAlign? textAlign,
      TextOverflow? overflow,
      required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColors.baseFontColor,
          decoration: textDecoration,
          fontSize: fontSize ?? Dimensions.mFontSize22,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }

  static Widget mediumText(
      {int? maxLine,
      TextAlign? textAlign,
      TextOverflow? overflow,
      required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColors.baseFontColor,
          decoration: textDecoration,
          fontSize: fontSize ?? Dimensions.mFontSize14,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }

  static Widget smallText(
      {int? maxLine,
      TextAlign? textAlign,
      TextOverflow? overflow,
      required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColors.baseFontColor,
          decoration: textDecoration,
          fontSize: fontSize ?? Dimensions.mFontSize12,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }

  static Widget extraSmallText(
      {int? maxLine,
      TextAlign? textAlign,
      TextOverflow? overflow,
      required String text,
      Color? color,
      double? fontSize,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      String? fontFamily}) {
    return Text(
      text,
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(
          color: color ?? AppColors.baseFontColor,
          decoration: textDecoration,
          fontSize: fontSize ?? Dimensions.mFontSize9,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}
