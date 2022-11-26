// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as bool?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

DataResponse _$DataResponseFromJson(Map<String, dynamic> json) => DataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['image'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$DataResponseToJson(DataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'token': instance.token,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['data'] == null
          ? null
          : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..status = json['status'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

ExtendedIngredientsResponse _$ExtendedIngredientsResponseFromJson(
        Map<String, dynamic> json) =>
    ExtendedIngredientsResponse(
      json['amount'] as int?,
      json['nameClean'] as String?,
      json['unit'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$ExtendedIngredientsResponseToJson(
        ExtendedIngredientsResponse instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'nameClean': instance.nameClean,
      'unit': instance.unit,
      'image': instance.image,
    };

StepsResponse _$StepsResponseFromJson(Map<String, dynamic> json) =>
    StepsResponse(
      json['number'] as int?,
      json['step'] as String?,
    );

Map<String, dynamic> _$StepsResponseToJson(StepsResponse instance) =>
    <String, dynamic>{
      'number': instance.number,
      'step': instance.step,
    };

AnalyzedInstructionsResponse _$AnalyzedInstructionsResponseFromJson(
        Map<String, dynamic> json) =>
    AnalyzedInstructionsResponse(
      (json['steps'] as List<dynamic>?)
          ?.map((e) => StepsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyzedInstructionsResponseToJson(
        AnalyzedInstructionsResponse instance) =>
    <String, dynamic>{
      'steps': instance.steps,
    };

RecipeInformationResponse _$RecipeInformationResponseFromJson(
        Map<String, dynamic> json) =>
    RecipeInformationResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
      json['aggregateLikes'] as int?,
      json['cookingMinutes'] as int?,
      json['servings'] as int?,
      json['summary'] as String?,
      (json['extendedIngredients'] as List<dynamic>?)
          ?.map((e) =>
              ExtendedIngredientsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['analyzedInstructions'] == null
          ? null
          : AnalyzedInstructionsResponse.fromJson(
              json['analyzedInstructions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeInformationResponseToJson(
        RecipeInformationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'aggregateLikes': instance.aggregateLikes,
      'cookingMinutes': instance.cookingMinutes,
      'servings': instance.servings,
      'summary': instance.summary,
      'extendedIngredients': instance.extendedIngredients,
      'analyzedInstructions': instance.analyzedInstructions,
    };

RandomRecipesResponse _$RandomRecipesResponseFromJson(
        Map<String, dynamic> json) =>
    RandomRecipesResponse(
      (json['recipes'] as List<dynamic>?)
          ?.map((e) =>
              RecipeInformationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RandomRecipesResponseToJson(
        RandomRecipesResponse instance) =>
    <String, dynamic>{
      'recipes': instance.recipes,
    };

SearchRecipesResponse _$SearchRecipesResponseFromJson(
        Map<String, dynamic> json) =>
    SearchRecipesResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$SearchRecipesResponseToJson(
        SearchRecipesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
    };

SearchRecipesResultsResponse _$SearchRecipesResultsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchRecipesResultsResponse(
      (json['results'] as List<dynamic>?)
          ?.map(
              (e) => SearchRecipesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchRecipesResultsResponseToJson(
        SearchRecipesResultsResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };

AutoCompRecipeInfoResponse _$AutoCompRecipeInfoResponseFromJson(
        Map<String, dynamic> json) =>
    AutoCompRecipeInfoResponse(
      json['title'] as String?,
    );

Map<String, dynamic> _$AutoCompRecipeInfoResponseToJson(
        AutoCompRecipeInfoResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

AutoCompRecipesResultsResponse _$AutoCompRecipesResultsResponseFromJson(
        Map<String, dynamic> json) =>
    AutoCompRecipesResultsResponse(
      (json['titles'] as List<dynamic>?)
          ?.map((e) =>
              AutoCompRecipeInfoResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AutoCompRecipesResultsResponseToJson(
        AutoCompRecipesResultsResponse instance) =>
    <String, dynamic>{
      'titles': instance.titles,
    };
