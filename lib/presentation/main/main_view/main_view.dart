import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:paprika/presentation/main/pages/recipes/view/recipes_page.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../pages/home/view/home_page.dart';
import '../pages/settings/view/settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  List<Widget> pages = [HomePage(), RecipesPage(), SettingsPage()];
  List<String> titles = [
    AppStrings.inspiration,
    AppStrings.recipes,
    AppStrings.settings,
  ];
  String _title = AppStrings.inspiration;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
            items: [
              Image(
                  image: const AssetImage(ImageAssets.lamp),
                  height: AppSize.s28,
                  width: AppSize.s28,
                  color: ColorManager.black),
              Image(
                  image: const AssetImage(ImageAssets.chefHat),
                  height: AppSize.s28,
                  width: AppSize.s28,
                  color: ColorManager.black),
              Image(
                  image: const AssetImage(ImageAssets.settings),
                  height: AppSize.s20,
                  width: AppSize.s20,
                  color: ColorManager.black)
            ],
            onTap: _onTap,
            height: AppSize.s60,
            index: _currentIndex,
            backgroundColor: ColorManager.transparent,
            color: ColorManager.veryLightGrey,
            buttonBackgroundColor: ColorManager.lightWhite,
            animationDuration:
                const Duration(milliseconds: AppConstants.bottomNavTimer)));
  }

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
