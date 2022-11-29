import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchIngredientUseCase
    implements
        BaseUseCase<SearchIngredientUseCaseInput,
            List<SearchIngredientResults>> {
  final Repository _repository;

  SearchIngredientUseCase(this._repository);

  @override
  Future<Either<Failure, List<SearchIngredientResults>>> execute(
      SearchIngredientUseCaseInput input) async {
    return await _repository
        .searchIngredient(SearchRequest(input.number, input.query));
  }
}

class SearchIngredientUseCaseInput {
  int number;
  String query;

  SearchIngredientUseCaseInput(this.number, this.query);
}
