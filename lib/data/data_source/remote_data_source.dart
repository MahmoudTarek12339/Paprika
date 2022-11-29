import '../network/app_api.dart';
import '../network/requests.dart';
import '../resonse/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<RandomRecipesResponse> getRandomData(
      RandomRecipeRequest randomRecipeRequest);

  Future<RecipeInformationResponse> getRecipeInformation(int id);

  Future<SearchRecipesResultsResponse> searchRecipe(
      SearchRequest searchRequest);

  Future<AutoCompRecipesResultsResponse> searchRecipeAutoComp(
      SearchRequest searchRequest);

  Future<SearchIngredientResultsResponse> searchIngredient(
      SearchRequest searchRequest);

  Future<AutoCompIngredientsResultsResponse> searchIngredientAutoComp(
      SearchRequest searchRequest);

  Future<SearchRecipesWithIngResultsResponse> searchRecipeWithIng(
      SearchWithIngRequest searchWithIngRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  final AppServiceClient2 _appServiceClient2;

  RemoteDataSourceImpl(this._appServiceClient, this._appServiceClient2);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(registerRequest.email,
        registerRequest.password, registerRequest.phone, registerRequest.name);
  }

  @override
  Future<RandomRecipesResponse> getRandomData(
      RandomRecipeRequest randomRecipeRequest) async {
    return await _appServiceClient2.getRandomData(
        randomRecipeRequest.number, randomRecipeRequest.tags);
  }

  @override
  Future<RecipeInformationResponse> getRecipeInformation(int id) async {
    return await _appServiceClient2.getRecipeInformation(id);
  }

  @override
  Future<SearchRecipesResultsResponse> searchRecipe(
      SearchRequest searchRequest) async {
    return await _appServiceClient2.searchRecipe(
        searchRequest.number, searchRequest.query);
  }

  @override
  Future<AutoCompRecipesResultsResponse> searchRecipeAutoComp(
      SearchRequest searchRequest) async {
    return await _appServiceClient2.searchRecipeAutoComp(
        searchRequest.number, searchRequest.query);
  }

  @override
  Future<SearchIngredientResultsResponse> searchIngredient(
      SearchRequest searchRequest) async {
    return await _appServiceClient2.searchIngredient(
        searchRequest.number, searchRequest.query);
  }

  @override
  Future<AutoCompIngredientsResultsResponse> searchIngredientAutoComp(
      SearchRequest searchRequest) async {
    return await _appServiceClient2.searchIngredientAutoComp(
        searchRequest.number, searchRequest.query);
  }

  @override
  Future<SearchRecipesWithIngResultsResponse> searchRecipeWithIng(
      SearchWithIngRequest searchWithIngRequest) async {
    return await _appServiceClient2.searchRecipesWithIng(
        searchWithIngRequest.number, searchWithIngRequest.ingredients);
  }
}
