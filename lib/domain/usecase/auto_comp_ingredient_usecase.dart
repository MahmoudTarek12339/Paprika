import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';
import 'package:paprika/domain/model/models.dart';

import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class AutoCompIngredientUseCase
    implements
        BaseUseCase<AutoCompIngredientUseCaseInput,
            List<SearchIngredientResults>> {
  final Repository _repository;

  AutoCompIngredientUseCase(this._repository);

  @override
  Future<Either<Failure, List<SearchIngredientResults>>> execute(
      AutoCompIngredientUseCaseInput input) async {
    return await _repository
        .searchIngredientAutoComp(SearchRequest(input.number, input.query));
  }
}

class AutoCompIngredientUseCaseInput {
  int number;
  String query;

  AutoCompIngredientUseCaseInput(this.number, this.query);
}
