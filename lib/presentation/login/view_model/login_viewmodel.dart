import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/freezed_data/freezed_data_classes.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../domain/usecase/login_usecase.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  LoginObject loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  //inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => inputState.add(ErrorState(
                  StateRendererType.popupErrorState,
                  failure.message,
                )), (data) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(userName: email);
    inputIsAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputIsAllInputsValid.add(null);
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _areAllInputsValidStreamController.sink;

  //outputs
  @override
  Stream<bool> get outIsAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isEmailValid(loginObject.userName);
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }
}

abstract class LoginViewModelInputs {
  login();

  setEmail(String email);

  setPassword(String password);

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outIsAllInputsValid;
}
