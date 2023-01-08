import 'dart:async';

import 'package:paprika/domain/model/models.dart';
import 'package:paprika/domain/usecase/recipe_information_usecase.dart';
import 'package:paprika/domain/usecase/search_ingredients_recipe_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';

class IngredientRecipesResultsViewModel extends BaseViewModel
    with
        IngredientRecipesResultsViewModelInputs,
        IngredientRecipesResultsViewModelOutputs {
  final _recipesResultStreamController =
      StreamController<List<SearchRecipeWithIngResult>>.broadcast();
  final SearchIngredientsRecipeUseCase _searchIngredientsRecipeUseCase;
  final RecipeInformationUseCase _recipeInformationUseCase;

  IngredientRecipesResultsViewModel(
      this._searchIngredientsRecipeUseCase, this._recipeInformationUseCase);

  // --inputs
  @override
  Sink get inputRecipesResult => _recipesResultStreamController.sink;

  // --outputs
  @override
  Stream<List<SearchRecipeWithIngResult>> get outputRecipesResult =>
      _recipesResultStreamController.stream.map((result) => result);

  // --functions
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  searchRecipes(String ingredients) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _searchIngredientsRecipeUseCase
            .execute(SearchIngredientsRecipeUseCaseInput(15, ingredients)))
        .fold(
            (failure) => inputState.add(
                ErrorState(StateRendererType.popupErrorState, failure.message)),
            (data) {
      inputRecipesResult.add(data);
      inputState.add(ContentState());
    });
  }

  @override
  Future<RecipeData?> getRecipe(int id) async {
    RecipeData? recipe;
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _recipeInformationUseCase.execute(RecipeInformationUseCaseInput(id)))
        .fold(
            (failure) => inputState.add(
                ErrorState(StateRendererType.popupErrorState, failure.message)),
            (data) {
      inputState.add(ContentState());
      recipe = data;
    });
    return recipe;
  }

  @override
  void dispose() {
    _recipesResultStreamController.close();
    super.dispose();
  }
}

abstract class IngredientRecipesResultsViewModelInputs {
  searchRecipes(String ingredients);

  Future<RecipeData?> getRecipe(int id);

  Sink get inputRecipesResult;
}

abstract class IngredientRecipesResultsViewModelOutputs {
  Stream<List<SearchRecipeWithIngResult>> get outputRecipesResult;
}
