import 'dart:async';

import 'package:paprika/domain/model/models.dart';
import 'package:paprika/domain/usecase/recipe_information_usecase.dart';
import 'package:paprika/domain/usecase/search_recipe_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';

class RecipesResultViewModel extends BaseViewModel
    with RecipesResultViewModelInputs, RecipesResultViewModelOutputs {
  final _recipesResultStreamController =
      StreamController<List<SearchRecipeResults>>.broadcast();
  final SearchRecipeUseCase _searchRecipeUseCase;
  final RecipeInformationUseCase _recipeInformationUseCase;

  RecipesResultViewModel(
      this._searchRecipeUseCase, this._recipeInformationUseCase);

  // --inputs
  @override
  Sink get inputRecipesResult => _recipesResultStreamController.sink;

  // --outputs
  @override
  Stream<List<SearchRecipeResults>> get outputRecipesResult =>
      _recipesResultStreamController.stream.map((result) => result);

  // --functions
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  searchRecipes(String query) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _searchRecipeUseCase.execute(SearchRecipeUseCaseInput(10, query)))
        .fold(
            (failure) => inputState.add(ErrorState(
                StateRendererType.fullScreenErrorState, failure.message)),
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

abstract class RecipesResultViewModelInputs {
  searchRecipes(String query);

  Future<RecipeData?> getRecipe(int id);

  Sink get inputRecipesResult;
}

abstract class RecipesResultViewModelOutputs {
  Stream<List<SearchRecipeResults>> get outputRecipesResult;
}
