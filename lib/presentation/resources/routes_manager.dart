import 'package:flutter/material.dart';
import 'package:paprika/app/di.dart';
import 'package:paprika/domain/model/models.dart';
import 'package:paprika/presentation/ingredientsRecipesResult/view/ingredients_recipes_result_view.dart';
import 'package:paprika/presentation/login/view/login_view.dart';
import 'package:paprika/presentation/onboarding/view/onboarding_view.dart';
import 'package:paprika/presentation/recipe/view/recipe_view.dart';
import 'package:paprika/presentation/recipesResults/view/recipes_results_view.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';
import 'package:paprika/presentation/searchIngredients/view/search_ingredients_view.dart';
import 'package:paprika/presentation/searchRecipe/view/search_recipe_view.dart';
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
  static const String searchRecipe = "/searchRecipe";
  static const String searchIngredient = "/searchIngredient";
  static const String recipesResults = '/recipesResults';
  static const String ingredientRecipesResults = '/ingredientRecipesResults';
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
      case Routes.searchRecipe:
        initSearchRecipeModule();
        return MaterialPageRoute(builder: (_) => const SearchRecipeView());
      case Routes.searchIngredient:
        initSearchIngredientModule();
        return MaterialPageRoute(builder: (_) => const SearchIngredientsView());
      case Routes.recipeDetails:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        RecipeData recipe = arguments['recipe'] as RecipeData;
        String tag = arguments['tag'] as String;
        return PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                  opacity: animation, child: RecipeView(recipe, tag));
            });
      case Routes.recipeSteps:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        RecipeData recipe = arguments['recipe'] as RecipeData;
        return MaterialPageRoute(builder: (_) => StepsView(recipe));
      case Routes.recipesResults:
        initRecipesResultModule();
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String query = arguments['query'] as String;
        return MaterialPageRoute(builder: (_) => RecipesResultsView(query));
      case Routes.ingredientRecipesResults:
        initIngredientRecipesResultModule();
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        String ingredients = arguments['ingredients'] as String;
        return MaterialPageRoute(
            builder: (_) => IngredientRecipesResultsView(ingredients));
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
