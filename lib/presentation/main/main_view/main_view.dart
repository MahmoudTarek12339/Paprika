import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:paprika/presentation/main/pages/favorites/view/favorites_page.dart';

import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../pages/home/view/home_page.dart';
import '../pages/search/view/search_page.dart';
import '../pages/settings/view/settings_page.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    FavoritesPage(),
    SettingsPage()
  ];
  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.favorites,
    AppStrings.settings,
  ];
  String _title = AppStrings.home;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
            items: const [
              Icon(Icons.home_outlined, size: AppSize.s30),
              Icon(Icons.search, size: AppSize.s30),
              Icon(Icons.favorite_border, size: AppSize.s30),
              Icon(Icons.settings, size: AppSize.s30),
            ],
            onTap: _onTap,
            height: AppSize.s60,
            index: _currentIndex,
            backgroundColor: Colors.transparent,
            color: ColorManager.lightPrimary,
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
