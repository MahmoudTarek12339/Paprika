import 'package:paprika/app/extensions.dart';

import '../../app/constants.dart';
import '../../domain/model/models.dart';
import '../resonse/responses.dart';

extension DataResponseMapper on DataResponse? {
  Data toDomain() {
    return Data(
      this?.id.orZero() ?? Constants.zero,
      this?.name.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.token.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  User toDomain() {
    return User(this?.data.toDomain());
  }
}

extension ExtendedIngredientsResponseMapper on ExtendedIngredientsResponse? {
  RecipeIngredients toDomain() {
    return RecipeIngredients(
        this?.amount.orZero() ?? Constants.zero,
        this?.nameClean.orEmpty() ?? Constants.empty,
        this?.unit.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension StepsResponseMapper on StepsResponse? {
  RecipeSteps toDomain() {
    return RecipeSteps(this?.step.orEmpty() ?? Constants.empty,
        this?.number.orZero() ?? Constants.zero);
  }
}

extension AnalyzedInstructionsResponseMapper on AnalyzedInstructionsResponse? {
  List<RecipeSteps> toDomain() {
    List<RecipeSteps> recipeSteps =
        (this?.steps?.map((stepResponse) => stepResponse.toDomain()) ??
                const Iterable.empty())
            .cast<RecipeSteps>()
            .toList();
    return recipeSteps;
  }
}

extension RecipeInformationResponseMapper on RecipeInformationResponse? {
  RecipeData toDomain() {
    RecipeInformation recipeInformation = RecipeInformation(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty,
        this?.aggregateLikes.orZero() ?? Constants.zero,
        this?.cookingMinutes.orZero() ?? Constants.zero,
        this?.servings.orZero() ?? Constants.zero,
        this?.summary.orEmpty() ?? Constants.empty);
    List<RecipeIngredients> recipeIngredients = (this
                ?.extendedIngredients
                ?.map((recipeIngredient) => recipeIngredient.toDomain()) ??
            const Iterable.empty())
        .cast<RecipeIngredients>()
        .toList();
    return RecipeData(recipeInformation, recipeIngredients,
        this?.analyzedInstructions.toDomain());
  }
}

extension RandomRecipesResponseMapper on RandomRecipesResponse? {
  List<RecipeData> toDomain() {
    List<RecipeData> randomRecipes =
        (this?.recipes?.map((recipe) => recipe.toDomain()) ??
                const Iterable.empty())
            .cast<RecipeData>()
            .toList();
    return randomRecipes;
  }
}

extension SearchRecipesResponseMapper on SearchRecipesResponse? {
  SearchRecipeResults toDomain() {
    return SearchRecipeResults(
        this?.id.orZero() ?? Constants.zero,
        this?.title.orEmpty() ?? Constants.empty,
        this?.image.orEmpty() ?? Constants.empty);
  }
}

extension SearchRecipesResultsResponseMapper on SearchRecipesResultsResponse? {
  List<SearchRecipeResults> toDomain() {
    List<SearchRecipeResults> recipeResults =
        (this?.results?.map((result) => result.toDomain()) ??
                const Iterable.empty())
            .cast<SearchRecipeResults>()
            .toList();
    return recipeResults;
  }
}

extension AutoCompRecipeInfoResponseMapper on AutoCompRecipeInfoResponse? {
  String toDomain() {
    return this?.title.orEmpty() ?? Constants.empty;
  }
}

extension AutoCompRecipesResultsResponseMapper
    on AutoCompRecipesResultsResponse? {
  List<String> toDomain() {
    List<String> titles = (this?.titles?.map((title) => title.toDomain()) ??
            const Iterable.empty())
        .cast<String>()
        .toList();
    return titles;
  }
}
