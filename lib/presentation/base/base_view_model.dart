import 'dart:async';

import 'package:paprika/domain/model/models.dart';
import 'package:rxdart/rxdart.dart';

import '../common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and function that will be used through any view model.
  final StreamController _inputStreamController = BehaviorSubject<FlowState>();

  final StreamController _inputIngredientStreamController =
      BehaviorSubject<List<Ingredient>>();

  List<Ingredient> _ingredients = [];

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Sink get inputIngredient => _inputIngredientStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  Stream<List<Ingredient>> get outputIngredients =>
      _inputIngredientStreamController.stream.map((ingredients) => ingredients);

  @override
  void dispose() {
    _inputStreamController.close();
    _inputIngredientStreamController.close();
  }

  @override
  void updateIngredients(Ingredient ingredient) {
    if (_ingredients
        .where((element) =>
            element.name.toLowerCase() == ingredient.name.toLowerCase())
        .isEmpty) {
      _ingredients.add(ingredient);
    } else {
      _ingredients.removeWhere((element) => element.name == ingredient.name);
    }
    inputIngredient.add(_ingredients);
  }

  @override
  void clearIngredients() {
    _ingredients.clear();
    inputIngredient.add(_ingredients);
  }

  @override
  List<Ingredient> getIngredients() {
    return _ingredients;
  }
}

abstract class BaseViewModelInputs {
  void start(); // start view model job

  void dispose(); // will be called when view model dies

  void updateIngredients(Ingredient ingredient);

  void clearIngredients();

  List<Ingredient> getIngredients();

  Sink get inputState;

  Sink get inputIngredient;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;

  Stream<List<Ingredient>> get outputIngredients;
}
