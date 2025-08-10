import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulf_car_auction/settings/settings.dart';

abstract class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      useMaterial3: false,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
      ),
      primaryColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: accentColor.withOpacity(0.3),
        selectionHandleColor: accentColor,
        cursorColor: accentColor,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: secondaryText,
          size: 26,
        ),
      ),
      iconTheme: IconThemeData(
        color: AppColors.baseColor,
        size: 16,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: accentColor,
          primaryContainer: accentColor,
          secondary: accentColor,
          secondaryContainer: accentColor,
          surface: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: primaryText.withOpacity(0.5),
        ),
        hintStyle: TextStyle(
          color: secondaryText,
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
      unselectedWidgetColor: AppColors.lightGrey,
      fontFamily: AppFonts.mulish,
      textTheme: TextTheme(
        headlineLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: AppFonts.mulish,
          color: primaryText,
          fontSize: 20,
        ),
        headlineMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 16,
        ),
        headlineSmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 12,
        ),
        titleLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: AppFonts.mulish,
          color: primaryText,
          fontSize: 20,
        ),
        titleMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 16,
        ),
        titleSmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 12,
        ),
        labelLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: AppFonts.mulish,
          color: primaryText,
          fontSize: 20,
        ),
        labelMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 16,
        ),
        labelSmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 12,
        ),
        displayLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: AppFonts.mulish,
          color: primaryText,
          fontSize: 20,
        ),
        displayMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 16,
        ),
        displaySmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 12,
        ),
        bodyLarge: baseTextTheme.displayLarge!.copyWith(
          fontFamily: AppFonts.mulish,
          color: primaryText,
          fontSize: 20,
        ),
        bodyMedium: baseTextTheme.displayMedium!.copyWith(
          color: primaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 16,
        ),
        bodySmall: baseTextTheme.displaySmall!.copyWith(
          color: secondaryText,
          fontFamily: AppFonts.mulish,
          fontSize: 12,
        ),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
        brightness: Brightness.light,
        background: AppColors.lightScaffoldBackgroundColor,
        cardBackground: AppColors.secondaryAppColor,
        primaryText: Colors.black,
        secondaryText: Colors.black,
        accentColor: AppColors.secondaryAppColor,
        divider: AppColors.secondaryAppColor,
        buttonBackground: Colors.black38,
        buttonText: AppColors.secondaryAppColor,
        disabled: AppColors.secondaryAppColor,
        error: Colors.red,
      );

  static ThemeData get darkTheme => createTheme(
        brightness: Brightness.dark,
        background: AppColors.darkScaffoldBackgroundColor,
        cardBackground: AppColors.secondaryDarkAppColor,
        primaryText: Colors.white,
        secondaryText: Colors.black,
        accentColor: AppColors.secondaryDarkAppColor,
        divider: Colors.black45,
        buttonBackground: Colors.white,
        buttonText: AppColors.secondaryDarkAppColor,
        disabled: AppColors.secondaryDarkAppColor,
        error: Colors.red,
      );
}
