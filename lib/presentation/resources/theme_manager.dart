
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
    splashColor: ColorManager.lightPrimary,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.primary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white),
    ),
    buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s18),
            primary: ColorManager.darkPrimary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    textTheme: TextTheme(
        displayLarge: getBoldtStyle(
            color: ColorManager.darkPrimary, fontSize: FontSize.s24),
        displayMedium: getSemiBoldStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s18),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorManager.lightBlack, fontSize: FontSize.s14),
        headlineSmall: getRegularStyle(
            color: ColorManager.lightGrey, fontSize: FontSize.s16),
        titleMedium:
            getMediumStyle(color: ColorManager.primary, fontSize: FontSize.s16),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey),
        bodyMedium: getRegularStyle(color: ColorManager.grey2, fontSize: FontSize.s12),
        labelSmall:
            getBoldtStyle(color: ColorManager.primary, fontSize: FontSize.s12)),
    inputDecorationTheme: InputDecorationTheme(
        // content padding
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
  );
}
