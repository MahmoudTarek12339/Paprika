import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AutoCompRecipeUseCase
    implements BaseUseCase<AutoCompRecipeUseCaseInput, List<String>> {
  final Repository _repository;

  AutoCompRecipeUseCase(this._repository);

  @override
  Future<Either<Failure, List<String>>> execute(
      AutoCompRecipeUseCaseInput input) async {
    return await _repository
        .searchRecipeAutoComp(SearchRequest(input.number, input.query));
  }
}

class AutoCompRecipeUseCaseInput {
  int number;
  String query;

  AutoCompRecipeUseCaseInput(this.number, this.query);
}
