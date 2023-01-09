import 'dart:async';
import 'dart:developer';

import 'package:paprika/domain/model/models.dart';
import 'package:paprika/domain/usecase/home_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class CategoryRecipesViewModel extends BaseViewModel
    with CategoryRecipesViewModelInput, CategoryRecipesViewModelOutput {
  final StreamController _recipesStreamController =
      BehaviorSubject<List<RecipeData>>();

  final HomeUseCase _homeUseCase;

  CategoryRecipesViewModel(this._homeUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  getRecipesData(String category) async {

    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(HomeUseCaseInput(category.toLowerCase(), 15)))
        .fold((failure) => log(failure.message), (data) {
      inputState.add(ContentState());
      inputRecipesData.add(data);
    });
  }

  @override
  void dispose() {
    _recipesStreamController.close();
    super.dispose();
  }

  //inputs
  @override
  Sink get inputRecipesData => _recipesStreamController.sink;

  //output
  @override
  Stream<List<RecipeData>> get outputRecipesData =>
      _recipesStreamController.stream.map((recipes) => recipes);
}

abstract class CategoryRecipesViewModelInput {
  getRecipesData(String category);

  Sink get inputRecipesData;
}

abstract class CategoryRecipesViewModelOutput {
  Stream<List<RecipeData>> get outputRecipesData;
}
