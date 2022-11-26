import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RecipeInformationUseCase
    implements BaseUseCase<RecipeInformationUseCaseInput, RecipeData> {
  final Repository _repository;

  RecipeInformationUseCase(this._repository);

  @override
  Future<Either<Failure, RecipeData>> execute(
      RecipeInformationUseCaseInput input) async {
    return await _repository.getRecipeInformation(input.id);
  }
}

class RecipeInformationUseCaseInput {
  int id;

  RecipeInformationUseCaseInput(this.id);
}
