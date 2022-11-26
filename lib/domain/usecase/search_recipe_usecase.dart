import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchRecipeUseCase
    implements
        BaseUseCase<SearchRecipeUseCaseInput, List<SearchRecipeResults>> {
  final Repository _repository;

  SearchRecipeUseCase(this._repository);

  @override
  Future<Either<Failure, List<SearchRecipeResults>>> execute(
      SearchRecipeUseCaseInput input) async {
    return await _repository
        .searchRecipe(SearchRequest(input.number, input.query));
  }
}

class SearchRecipeUseCaseInput {
  int number;
  String query;

  SearchRecipeUseCaseInput(this.number, this.query);
}
