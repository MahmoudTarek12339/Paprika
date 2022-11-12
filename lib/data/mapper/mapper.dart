import 'package:paprika/app/extensions.dart';

import '../../app/constants.dart';
import '../../domain/model/models.dart';
import '../resonse/responses.dart';

extension DataResponseMapper on DataResponse? {
  Data toDomain() {
    return Data(
      this?.id.orZero() ?? Constants.zero,
      this?.name.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.phone.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.token.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  User toDomain() {
    return User(this?.data.toDomain());
  }
}
