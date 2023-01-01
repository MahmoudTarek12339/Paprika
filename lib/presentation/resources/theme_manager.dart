import 'package:flutter/material.dart';
import 'package:paprika/presentation/resources/styles_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      titleTextStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white),
    ),
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s18),
            primary: ColorManager.darkPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    textTheme: TextTheme(
        displayLarge: getBoldtStyle(
            color: ColorManager.darkPrimary, fontSize: FontSize.s64),
        displayMedium: getSemiBoldStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s24),
        displaySmall: getSemiBoldStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s16),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s24),
        headlineMedium: getSemiBoldStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s18),
        headlineSmall: getSemiBoldStyle(
            color: ColorManager.lightGrey, fontSize: FontSize.s14),
        titleLarge:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s22),
        titleMedium:
            getMediumStyle(color: ColorManager.grey2, fontSize: FontSize.s18),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
        labelSmall:
            getBoldtStyle(color: ColorManager.grey1, fontSize: FontSize.s12),
        bodySmall:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s14),
        bodyLarge:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
        bodyMedium: getSemiBoldStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s14),
        labelMedium:
            getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelLarge:
            getSemiBoldStyle(color: ColorManager.black, fontSize: FontSize.s16)),
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(
            color: ColorManager.darkBlue, fontSize: FontSize.s14),
        labelStyle: getMediumStyle(
            color: ColorManager.darkBlue, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
  );
}
