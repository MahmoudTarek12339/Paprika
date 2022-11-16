import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              // navigate to on boarding screen
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: const AssetImage(ImageAssets.splash),
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppPadding.p100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.paprika,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: AppSize.s2),
                Text(
                  AppStrings.recipesWorld,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
