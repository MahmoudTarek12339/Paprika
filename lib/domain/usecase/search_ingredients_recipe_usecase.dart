import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchIngredientsRecipeUseCase
    implements
        BaseUseCase<SearchIngredientsRecipeUseCaseInput,
            List<SearchRecipeWithIngResult>> {
  final Repository _repository;

  SearchIngredientsRecipeUseCase(this._repository);

  @override
  Future<Either<Failure, List<SearchRecipeWithIngResult>>> execute(
      SearchIngredientsRecipeUseCaseInput input) async {
    return await _repository.searchRecipeWithIng(
        SearchWithIngRequest(input.ingredients, input.number));
  }
}

class SearchIngredientsRecipeUseCaseInput {
  int number;
  String ingredients;

  SearchIngredientsRecipeUseCaseInput(this.number, this.ingredients);
}
