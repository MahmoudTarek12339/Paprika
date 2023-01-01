import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "token")
  String? token;

  DataResponse(
      this.id, this.name, this.email, this.phone, this.image, this.token);

  // from json
  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "data")
  DataResponse? data;

  AuthenticationResponse(this.data);

  // from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ExtendedIngredientsResponse {
  @JsonKey(name: "amount")
  double? amount;
  @JsonKey(name: "nameClean")
  String? nameClean;
  @JsonKey(name: "unit")
  String? unit;
  @JsonKey(name: "image")
  String? image;

  ExtendedIngredientsResponse(
      this.amount, this.nameClean, this.unit, this.image);

  // from json
  factory ExtendedIngredientsResponse.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ExtendedIngredientsResponseToJson(this);
}

@JsonSerializable()
class StepsResponse {
  @JsonKey(name: "number")
  int? number;
  @JsonKey(name: "step")
  String? step;

  StepsResponse(this.number, this.step);

  // from json
  factory StepsResponse.fromJson(Map<String, dynamic> json) =>
      _$StepsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$StepsResponseToJson(this);
}

@JsonSerializable()
class AnalyzedInstructionsResponse {
  @JsonKey(name: "steps")
  List<StepsResponse>? steps;

  AnalyzedInstructionsResponse(this.steps);

  // from json
  factory AnalyzedInstructionsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AnalyzedInstructionsResponseToJson(this);
}

@JsonSerializable()
class RecipeInformationResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "aggregateLikes")
  int? aggregateLikes;
  @JsonKey(name: "readyInMinutes")
  int? readyInMinutes;
  @JsonKey(name: "healthScore")
  int? healthScore;
  @JsonKey(name: "servings")
  int? servings;
  @JsonKey(name: "summary")
  String? summary;
  @JsonKey(name: "extendedIngredients")
  List<ExtendedIngredientsResponse>? extendedIngredients;
  @JsonKey(name: "analyzedInstructions")
  List<AnalyzedInstructionsResponse>? analyzedInstructions;

  RecipeInformationResponse(
      this.id,
      this.title,
      this.image,
      this.aggregateLikes,
      this.readyInMinutes,
      this.servings,
      this.summary,
      this.extendedIngredients,
      this.analyzedInstructions); // from json
  factory RecipeInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeInformationResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RecipeInformationResponseToJson(this);
}

@JsonSerializable()
class RandomRecipesResponse {
  @JsonKey(name: "recipes")
  List<RecipeInformationResponse>? recipes;

  RandomRecipesResponse(this.recipes);

  factory RandomRecipesResponse.fromJson(Map<String, dynamic> json) =>
      _$RandomRecipesResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$RandomRecipesResponseToJson(this);
}

@JsonSerializable()
class SearchRecipesResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;

  SearchRecipesResponse(this.id, this.title, this.image);

  //to json
  factory SearchRecipesResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRecipesResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchRecipesResponseToJson(this);
}

@JsonSerializable()
class SearchRecipesResultsResponse {
  @JsonKey(name: "results")
  List<SearchRecipesResponse>? results;

  SearchRecipesResultsResponse(this.results);

  //to json
  factory SearchRecipesResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRecipesResultsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchRecipesResultsResponseToJson(this);
}

@JsonSerializable()
class SearchIngredientResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "image")
  String? image;

  SearchIngredientResponse(this.id, this.name, this.image);

  //to json
  factory SearchIngredientResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchIngredientResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchIngredientResponseToJson(this);
}

@JsonSerializable()
class SearchIngredientResultsResponse {
  @JsonKey(name: "results")
  List<SearchIngredientResponse>? results;

  SearchIngredientResultsResponse(this.results);

  //to json
  factory SearchIngredientResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchIngredientResultsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() =>
      _$SearchIngredientResultsResponseToJson(this);
}

@JsonSerializable()
class SearchRecipesWithIngResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "image")
  String? image;
  @JsonKey(name: "usedIngredientCount")
  int? usedIngredientCount;
  @JsonKey(name: "missedIngredientCount")
  int? missedIngredientCount;

  SearchRecipesWithIngResponse(this.id, this.title, this.image,
      this.usedIngredientCount, this.missedIngredientCount);

  //to json
  factory SearchRecipesWithIngResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchRecipesWithIngResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$SearchRecipesWithIngResponseToJson(this);
}

@JsonSerializable()
class SearchRecipesWithIngResultsResponse {
  List<SearchRecipesWithIngResponse>? results;

  SearchRecipesWithIngResultsResponse(this.results);

  //to json
  factory SearchRecipesWithIngResultsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$SearchRecipesWithIngResultsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() =>
      _$SearchRecipesWithIngResultsResponseToJson(this);
}

@JsonSerializable()
class AutoCompRecipeInfoResponse {
  @JsonKey(name: "title")
  String? title;

  AutoCompRecipeInfoResponse(this.title);

  //to json
  factory AutoCompRecipeInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AutoCompRecipeInfoResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AutoCompRecipeInfoResponseToJson(this);
}

@JsonSerializable()
class AutoCompRecipesResultsResponse {
  List<AutoCompRecipeInfoResponse>? titles;

  AutoCompRecipesResultsResponse(this.titles);

  //to json
  factory AutoCompRecipesResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$AutoCompRecipesResultsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$AutoCompRecipesResultsResponseToJson(this);
}

@JsonSerializable()
class AutoCompIngredientsResultsResponse {
  List<SearchIngredientResponse>? titles;

  AutoCompIngredientsResultsResponse(this.titles);

  //to json
  factory AutoCompIngredientsResultsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AutoCompIngredientsResultsResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() =>
      _$AutoCompIngredientsResultsResponseToJson(this);
}
