import 'package:dio/dio.dart';
import 'package:paprika/app/constants.dart';
import 'package:retrofit/http.dart';

import '../resonse/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('login')
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST('register')
  Future<AuthenticationResponse> register(
    @Field("email") String email,
    @Field("password") String password,
    @Field("phone") String phone,
    @Field("name") String name,
  );
}

@RestApi(baseUrl: Constants.baseUrl2)
abstract class AppServiceClient2 {
  factory AppServiceClient2(Dio dio, {String baseUrl}) = _AppServiceClient2;

  @GET('/recipes/random')
  Future<RandomRecipesResponse> getRandomData(
      @Query("number") int number, @Query("tags") String tags);

  @GET('/recipes/:id/information')
  Future<RecipeInformationResponse> getRecipeInformation(@Path("id") int id);

  @GET('/recipes/complexSearch')
  Future<SearchRecipesResultsResponse> searchRecipe(
      @Query("number") int number, @Query("query") String query);

  @GET('/recipes/autocomplete')
  Future<AutoCompRecipesResultsResponse> searchRecipeAutoComp(
      @Query("number") int number, @Query("query") String query);

  @GET('/food/ingredients/search')
  Future<SearchIngredientResultsResponse> searchIngredient(
      @Query("number") int number, @Query("query") String query);

  @GET('/food/ingredients/autocomplete')
  Future<AutoCompIngredientsResultsResponse> searchIngredientAutoComp(
      @Query("number") int number, @Query("query") String query);

  @GET('/recipes/findByIngredients')
  Future<SearchRecipesWithIngResultsResponse> searchRecipesWithIng(
      @Query("number") int number, @Query("query") String ingredients);
}
