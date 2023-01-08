import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:paprika/data/data_source/local_data_source.dart';
import 'package:paprika/domain/usecase/auto_comp_ingredient_usecase.dart';
import 'package:paprika/domain/usecase/auto_comp_recipe_usecase.dart';
import 'package:paprika/domain/usecase/home_usecase.dart';
import 'package:paprika/domain/usecase/recipe_information_usecase.dart';
import 'package:paprika/domain/usecase/register_usecase.dart';
import 'package:paprika/domain/usecase/search_ingredients_recipe_usecase.dart';
import 'package:paprika/domain/usecase/search_recipe_usecase.dart';
import 'package:paprika/presentation/ingredientsRecipesResult/view_model/ingredients_recipes_result_viewmodel.dart';
import 'package:paprika/presentation/main/pages/home/view_model/home_viewmodel.dart';
import 'package:paprika/presentation/recipesResults/view_model/recipes_results_viewmodel.dart';
import 'package:paprika/presentation/searchIngredients/view_model/search_ingredients_viewmodel.dart';
import 'package:paprika/presentation/searchRecipe/view_model/search_recipe_viewmodel.dart';
import 'package:paprika/presentation/signup/view_model/signup_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/network_info.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/login_usecase.dart';
import '../presentation/login/view_model/login_viewmodel.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreference = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreference);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //todo add preferences
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();
  Dio dio2 = await instance<DioFactory>().getDio2();

  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  instance
      .registerLazySingleton<AppServiceClient2>(() => AppServiceClient2(dio2));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
      instance<AppServiceClient>(), instance<AppServiceClient2>()));

  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomePageViewModel>(
        () => HomePageViewModel(instance()));
  }
}

initSearchRecipeModule() {
  if (!GetIt.I.isRegistered<AutoCompRecipeUseCase>()) {
    instance.registerFactory<AutoCompRecipeUseCase>(
        () => AutoCompRecipeUseCase(instance()));
    instance.registerFactory<SearchRecipeViewModel>(
        () => SearchRecipeViewModel(instance()));
  }
}

initSearchIngredientModule() {
  if (!GetIt.I.isRegistered<AutoCompIngredientUseCase>()) {
    instance.registerFactory<AutoCompIngredientUseCase>(
        () => AutoCompIngredientUseCase(instance()));
    instance.registerFactory<SearchIngredientViewModel>(
        () => SearchIngredientViewModel(instance()));
  }
}

initRecipesResultModule() {
  if (!GetIt.I.isRegistered<SearchRecipeUseCase>() ||
      !GetIt.I.isRegistered<RecipeInformationUseCase>()) {
    instance.registerFactory<SearchRecipeUseCase>(
        () => SearchRecipeUseCase(instance()));
    instance.registerFactory<RecipeInformationUseCase>(
        () => RecipeInformationUseCase(instance()));
    instance.registerFactory<RecipesResultViewModel>(
        () => RecipesResultViewModel(instance(), instance()));
  }
}

initIngredientRecipesResultModule() {
  if (!GetIt.I.isRegistered<SearchIngredientsRecipeUseCase>() ||
      !GetIt.I.isRegistered<RecipeInformationUseCase>()) {
    instance.registerFactory<SearchIngredientsRecipeUseCase>(
        () => SearchIngredientsRecipeUseCase(instance()));
    instance.registerFactory<RecipeInformationUseCase>(
        () => RecipeInformationUseCase(instance()));
    instance.registerFactory<IngredientRecipesResultsViewModel>(
        () => IngredientRecipesResultsViewModel(instance(), instance()));
  }
}
