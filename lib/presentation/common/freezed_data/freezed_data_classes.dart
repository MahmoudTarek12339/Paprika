import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
          String email, String password, String phone, String name) =
      _RegisterObject;
}

@freezed
class SearchObject with _$SearchObject {
  factory SearchObject(String query, int number) = _SearchObject;
}
