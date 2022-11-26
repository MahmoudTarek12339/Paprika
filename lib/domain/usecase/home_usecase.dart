import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<HomeUseCaseInput, List<RecipeData>> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, List<RecipeData>>> execute(
      HomeUseCaseInput input) async {
    return await _repository
        .getRandomData(RandomRecipeRequest(input.tags, input.number));
  }
}

class HomeUseCaseInput {
  String tags;
  int number;

  HomeUseCaseInput(this.tags, this.number);
}
