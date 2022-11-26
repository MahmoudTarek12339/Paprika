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
  int? amount;
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
  @JsonKey(name: "cookingMinutes")
  int? cookingMinutes;
  @JsonKey(name: "servings")
  int? servings;
  @JsonKey(name: "summary")
  String? summary;
  @JsonKey(name: "extendedIngredients")
  List<ExtendedIngredientsResponse>? extendedIngredients;
  @JsonKey(name: "analyzedInstructions")
  AnalyzedInstructionsResponse? analyzedInstructions;

  RecipeInformationResponse(
      this.id,
      this.title,
      this.image,
      this.aggregateLikes,
      this.cookingMinutes,
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

