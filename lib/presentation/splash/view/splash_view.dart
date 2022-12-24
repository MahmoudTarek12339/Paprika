import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import '../../../app/app_prefs.dart';
import '../../../app/di.dart';
import '../../resources/assets_manager.dart';
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
          /*if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              // navigate to on boarding screen
              Navigator.pushReplacementNamed(context, Routes.onBoardingRoute)
            }*/
          Navigator.pushReplacementNamed(context, Routes.mainRoute)
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
        body: Stack(fit: StackFit.expand, children: [
      const Image(image: AssetImage(ImageAssets.splash), fit: BoxFit.fitHeight),
      Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedTextKit(isRepeatingAnimation: false, animatedTexts: [
              WavyAnimatedText(AppStrings.paprika,
                  textStyle: Theme.of(context).textTheme.displayLarge)
            ]),
            const SizedBox(height: AppSize.s2),
            Text(AppStrings.recipesWorld,
                style: Theme.of(context).textTheme.displayMedium)
          ]))
    ]));
  }
}
