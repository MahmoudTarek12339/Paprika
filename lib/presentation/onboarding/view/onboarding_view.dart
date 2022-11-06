import 'package:flutter/material.dart';
import 'package:paprika/presentation/resources/color_manager.dart';
import 'package:paprika/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Image(
            image: const AssetImage(ImageAssets.onBoarding),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          )),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.35,
              height: MediaQuery.of(context).size.height / 2.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  color: ColorManager.white.withOpacity(0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage(ImageAssets.chefHat),
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(
                        height: AppSize.s8,
                      ),
                      Text(
                        AppStrings.paprika,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(
                        'Nutritionally balanced, easy to cook recipes.',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: AppSize.s18,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          child: const Text('Create Account')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account?',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),

                          TextButton(
                              onPressed: () {}, child: const Text('Login'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
