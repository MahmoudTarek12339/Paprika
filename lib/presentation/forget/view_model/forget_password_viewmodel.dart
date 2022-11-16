import 'dart:async';

import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../app/functions.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInput, ForgetPasswordViewModelOutput {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  //final ForgotPasswordUseCase _forgotPasswordUseCase;

  //ForgotPasswordViewModel(this._forgotPasswordUseCase);

  String email = "";

  @override
  forgotPassword() {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputIsEmailValid => _isAllInputValidStreamController.sink;

  @override
  setEmail(String email) {
    this.email = email;
    _emailStreamController.add(email);
    inputIsEmailValid.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
    super.dispose();
  }

  //outputs
  @override
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream.map((_) => isEmailValid(email));

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));
}

abstract class ForgetPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsEmailValid;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsAllInputValid;
}
