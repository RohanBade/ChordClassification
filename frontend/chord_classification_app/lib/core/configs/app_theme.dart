import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../extensions/color_extensions.dart';
import '../extensions/textstyle_extensions.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

////////////////////////App Themes////////////////////////////////
final class AppThemes {
  AppThemes._();
  static ThemeData get darkTheme => ThemeData(
      brightness: Brightness.dark,
      disabledColor: AppColors.white,
      fontFamily: 'inter',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryIconTheme: Icontheme.darkIconTheme,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(primary: AppColors.primary),
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      iconTheme: Icontheme.darkIconTheme,
      switchTheme: SwitchThemeData(
          trackColor:
              WidgetStateColor.resolveWith((states) => AppColors.primary.o5),
          thumbColor:
              WidgetStateColor.resolveWith((states) => AppColors.white)),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColors.transparent),
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor:
                  WidgetStateColor.resolveWith((states) => AppColors.white))),
      cardColor: AppColors.black,
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 45.h,
          backgroundColor: AppColors.black,
          iconTheme: IconThemeData(size: 23.sp, color: AppColors.white),
          actionsIconTheme: IconThemeData(color: AppColors.white, size: 15.sp),
          titleTextStyle: TextThemes.darkTextTheme.bodyMedium!.px16));

  static ThemeData get lightTheme => ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      disabledColor: AppColors.black,
      fontFamily: 'inter',
      primaryIconTheme: Icontheme.lightIconTheme,
      textTheme: TextThemes.primaryTextTheme,
      primaryColor: AppColors.primary,
      cardColor: AppColors.white,
      useMaterial3: false,
      switchTheme: SwitchThemeData(
          trackColor:
              WidgetStateColor.resolveWith((states) => AppColors.primary.o5),
          thumbColor:
              WidgetStateColor.resolveWith((states) => AppColors.white)),
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColors.transparent),
      colorScheme: const ColorScheme.light(
          brightness: Brightness.light, primary: AppColors.primary),
      scaffoldBackgroundColor: AppColors.white,
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
              iconColor:
                  WidgetStateColor.resolveWith((states) => AppColors.black))),
      appBarTheme: AppBarTheme(
          elevation: 0,
          toolbarHeight: 45.h,
          centerTitle: true,
          titleTextStyle: TextThemes.primaryTextTheme.bodyMedium!.px18,
          backgroundColor: AppColors.white,
          actionsIconTheme: IconThemeData(color: AppColors.black, size: 18.sp),
          iconTheme: IconThemeData(size: 23.sp, color: AppColors.black)));

  static CupertinoThemeData get iosdarkTheme => MaterialBasedCupertinoThemeData(
      materialTheme: AppThemes.darkTheme.copyWith(
          cupertinoOverrideTheme: CupertinoThemeData(
              primaryContrastingColor: AppColors.primary,
              scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
              barBackgroundColor: AppColors.iosBlack,
              applyThemeToAll: true,
              textTheme: CupertinoTextThemeData(
                  primaryColor: AppColors.iosWhite,
                  textStyle: TextThemes.darkTextTheme.bodyMedium!.px19),
              primaryColor: AppColors.primary,
              brightness: Brightness.dark)));

  static CupertinoThemeData get ioslightTheme =>
      MaterialBasedCupertinoThemeData(
          materialTheme: AppThemes.lightTheme.copyWith(
              cupertinoOverrideTheme: CupertinoThemeData(
                  primaryContrastingColor: AppColors.primary,
                  scaffoldBackgroundColor: AppColors.iosWhite,
                  barBackgroundColor: AppColors.iosWhite,
                  primaryColor: AppColors.primary,
                  applyThemeToAll: true,
                  textTheme: CupertinoTextThemeData(
                      primaryColor: AppColors.iosBlack,
                      textStyle: TextThemes.primaryTextTheme.bodyMedium!.px19),
                  brightness: Brightness.light)));
}

////////////////////////AppText Theme////////////////////////////////
final class TextThemes {
  static TextTheme get textTheme {
    return TextTheme(
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall);
  }

  static TextTheme get darkTextTheme {
    Color textColor = AppColors.white;
    return TextTheme(
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: textColor));
  }

  static TextTheme get primaryTextTheme {
    Color textColor = AppColors.black;
    return TextTheme(
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textColor),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textColor),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: textColor));
  }
}

////////////////////////Icon Theme////////////////////////////////
final class Icontheme {
  static IconThemeData get lightIconTheme =>
      IconThemeData(size: 23.sp, color: AppColors.black);
  static IconThemeData get darkIconTheme =>
      IconThemeData(size: 23.sp, color: AppColors.white);
}
