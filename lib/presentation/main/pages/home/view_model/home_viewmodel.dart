import 'dart:async';

import 'package:paprika/domain/model/models.dart';
import 'package:paprika/domain/usecase/home_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomePageViewModel extends BaseViewModel
    with HomePageViewModelInput, HomePageViewModelOutput {
  final StreamController _forYouStreamController =
      BehaviorSubject<List<RecipeData>>();
  final StreamController _masterChefStreamController =
      BehaviorSubject<List<RecipeData>>();

  final HomeUseCase _homeUseCase;

  HomePageViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(HomeUseCaseInput('soup', 10))).fold(
        (failure) => inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message)),
        (forYouData) async {
      inputForYouData.add(forYouData);
      (await _homeUseCase.execute(HomeUseCaseInput('lunch', 10))).fold(
          (failure2) => inputState.add(ErrorState(
              StateRendererType.fullScreenErrorState, failure2.message)),
          (masterChefData) {
        inputState.add(ContentState());
        inputMasterChefData.add(masterChefData);
      });
    });
  }

  @override
  void dispose() {
    _forYouStreamController.close();
    _masterChefStreamController.close();
    super.dispose();
  }

  //inputs
  @override
  Sink get inputForYouData => _forYouStreamController.sink;

  @override
  Sink get inputMasterChefData => _masterChefStreamController.sink;

  //output
  @override
  Stream<List<RecipeData>> get outputForYouData =>
      _forYouStreamController.stream.map((recipes) => recipes);

  @override
  Stream<List<RecipeData>> get outputMasterChefData =>
      _masterChefStreamController.stream.map((recipes) => recipes);
}

abstract class HomePageViewModelInput {
  Sink get inputForYouData;

  Sink get inputMasterChefData;
}

abstract class HomePageViewModelOutput {
  Stream<List<RecipeData>> get outputForYouData;

  Stream<List<RecipeData>> get outputMasterChefData;
}
