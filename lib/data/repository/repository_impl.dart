import 'package:dartz/dartz.dart';
import 'package:paprika/data/data_source/local_data_source.dart';
import 'package:paprika/data/mapper/mapper.dart';

import '../../domain/model/models.dart';
import '../../domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../network/error_handler.dart';
import '../network/failure.dart';
import '../network/network_info.dart';
import '../network/requests.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, User>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);

        if (response.status == true) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, User>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == true) {
          // success
          // return either right
          // return data
          return Right(response.toDomain());
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeData>>> getRandomData(
      RandomRecipeRequest randomRecipeRequest) async {
    try {
      final response = await _localDataSource
          .getHomeData(randomRecipeRequest.tags == 'soup');

      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response =
              await _remoteDataSource.getRandomData(randomRecipeRequest);
          // success
          // return data
          _localDataSource.saveHomeToCache(
              response, randomRecipeRequest.tags == 'soup');
          return Right(response.toDomain());
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, RecipeData>> getRecipeInformation(int id) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getRecipeInformation(id);
        // success
        // return either right
        // return data
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchRecipeResults>>> searchRecipe(
      SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.searchRecipe(searchRequest);
        // success
        // return either right
        // return data
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> searchRecipeAutoComp(
      SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.searchRecipeAutoComp(searchRequest);
        // success
        // return either right
        // return data
        List<String> recipes =
            response.map((recipe) => recipe.toDomain()).toList();
        return Right(recipes);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchIngredientResults>>> searchIngredient(
      SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.searchIngredient(searchRequest);
        // success
        // return either right
        // return data
        return Right(response.toDomain());
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchIngredientResults>>>
      searchIngredientAutoComp(SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.searchIngredientAutoComp(searchRequest);
        // success
        // return either right
        // return data
        List<SearchIngredientResults> ingredients =
            response.map((ingredient) => ingredient.toDomain()).toList();
        return Right(ingredients);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<SearchRecipeWithIngResult>>> searchRecipeWithIng(
      SearchWithIngRequest searchWithIngRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.searchRecipeWithIng(searchWithIngRequest);
        // success
        // return either right
        // return data
        List<SearchRecipeWithIngResult> recipes =
            response.map((recipe) => recipe.toDomain()).toList();
        return Right(recipes);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
