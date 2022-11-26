import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../model/models.dart';

abstract class Repository {
  Future<Either<Failure, User>> login(LoginRequest loginRequest);

  Future<Either<Failure, User>> register(RegisterRequest registerRequest);

  Future<Either<Failure, List<RecipeData>>> getRandomData(
      RandomRecipeRequest randomRecipeRequest);

  Future<Either<Failure, RecipeData>> getRecipeInformation(int id);

  Future<Either<Failure, List<SearchRecipeResults>>> searchRecipe(
      SearchRequest searchRequest);

  Future<Either<Failure, List<String>>> searchRecipeAutoComp(
      SearchRequest searchRequest);
}
