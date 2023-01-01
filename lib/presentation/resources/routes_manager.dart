import 'package:flutter/material.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/login/view/login_view.dart';
import 'package:paprika/presentation/onboarding/view/onboarding_view.dart';
import 'package:paprika/presentation/recipe/view/recipe_view.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/signup/view/signup_view.dart';
import 'package:paprika/presentation/steps/view/steps_view.dart';

import '../main/main_view/main_view.dart';
import '../splash/view/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String onBoardingRoute = "/onBoarding";
  static const String mainRoute = "/main";
  static const String recipeDetails = "/recipe";
  static const String recipeSteps = "/steps";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.recipeDetails:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        RecipeData recipe = arguments['recipe'] as RecipeData;
        String tag = arguments['tag'] as String;
        return MaterialPageRoute(builder: (_) => RecipeView(recipe, tag));
      case Routes.recipeSteps:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        RecipeData recipe = arguments['recipe'] as RecipeData;
        return MaterialPageRoute(builder: (_) => StepsView(recipe));
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
