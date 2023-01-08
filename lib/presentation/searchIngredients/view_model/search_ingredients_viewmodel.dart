import 'dart:async';
import 'dart:developer';

import 'package:paprika/domain/model/models.dart';
import 'package:paprika/domain/usecase/auto_comp_ingredient_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';

class SearchIngredientViewModel extends BaseViewModel
    with SearchIngredientViewModelInputs, SearchIngredientViewModelOutputs {
  final StreamController _ingredientStreamController =
      StreamController<List<SearchIngredientResults>>.broadcast();

  late String query;

  final AutoCompIngredientUseCase _autoCompIngredientUseCase;

  SearchIngredientViewModel(this._autoCompIngredientUseCase); // --inputs

  @override
  Sink get inputSearchIngredients => _ingredientStreamController.sink;

  // --outputs
  @override
  Stream<List<SearchIngredientResults>> get outputSearchIngredients =>
      _ingredientStreamController.stream.map((result) => result);

  // --functions
  @override
  void start() {
    query = '';
  }

  @override
  void dispose() {
    _ingredientStreamController.close();
    //super.dispose();
  }

  @override
  autoCompIngredient() async {
    (await _autoCompIngredientUseCase
            .execute(AutoCompIngredientUseCaseInput(15, query)))
        .fold((failure) => log(failure.message),
            (data) => inputSearchIngredients.add(data));
  }

  @override
  clearQuery() {
    List<SearchIngredientResults> emptyList = [];
    inputSearchIngredients.add(emptyList);
  }

  @override
  setQuery(String query) {
    this.query = query;
    if (this.query.isNotEmpty) {
      autoCompIngredient();
    } else {
      clearQuery();
    }
  }
}

abstract class SearchIngredientViewModelInputs {
  setQuery(String query);

  clearQuery();

  autoCompIngredient();

  Sink get inputSearchIngredients;
}

abstract class SearchIngredientViewModelOutputs {
  Stream<List<SearchIngredientResults>> get outputSearchIngredients;
}
