import 'dart:async';
import 'dart:developer';
import 'package:paprika/domain/usecase/auto_comp_recipe_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';

class SearchRecipeViewModel extends BaseViewModel
    with SearchRecipeViewModelInputs, SearchRecipeViewModelOutputs {
  final StreamController _recipeStreamController =
      StreamController<List<String>>.broadcast();

  final AutoCompRecipeUseCase _autoCompRecipeUseCase;

  SearchRecipeViewModel(this._autoCompRecipeUseCase);

  late String query;

  @override
  void start() {
    query = '';
  }

  @override
  void dispose() {
    _recipeStreamController.close();
    super.dispose();
  }

  @override
  autoCompRecipe() async {
    (await _autoCompRecipeUseCase
            .execute(AutoCompRecipeUseCaseInput(10, query)))
        .fold(
            (failure) => log(failure.message), (data) => inputRecipe.add(data));
  }

  @override
  clearQuery() {
    List<String> emptyList = [];
    inputRecipe.add(emptyList);
  }

  @override
  setQuery(String query) {
    this.query = query;
    if (this.query.isNotEmpty) {
      autoCompRecipe();
    } else {
      clearQuery();
    }
  }

  // --input
  @override
  Sink get inputRecipe => _recipeStreamController.sink;

  // --output
  @override
  Stream<List<String>> get outputRecipes =>
      _recipeStreamController.stream.map((recipes) => recipes);
}

abstract class SearchRecipeViewModelInputs {
  setQuery(String query);

  clearQuery();

  autoCompRecipe();

  Sink get inputRecipe;
}

abstract class SearchRecipeViewModelOutputs {
  Stream<List<String>> get outputRecipes;
}
