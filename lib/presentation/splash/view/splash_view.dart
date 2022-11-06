import 'package:flutter/material.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
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
          Column(
            children: [
              const SizedBox(height: 195),
              Text(
                AppStrings.paprika,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: AppSize.s4),
              Text(
                AppStrings.recipesWorld,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28,
                      right: AppPadding.p28,
                      bottom: AppPadding.p100),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
                        },
                        child: const Text(AppStrings.startCooking)),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
