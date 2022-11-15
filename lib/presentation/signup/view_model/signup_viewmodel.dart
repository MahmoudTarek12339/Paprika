import 'dart:async';

import 'package:paprika/app/functions.dart';
import 'package:paprika/domain/usecase/register_usecase.dart';
import 'package:paprika/presentation/base/base_view_model.dart';
import 'package:paprika/presentation/common/freezed_data/freezed_data_classes.dart';
import 'package:paprika/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:paprika/presentation/resources/strings_manager.dart';

import '../../common/state_renderer/state_renderer.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _nameStreamController =
      StreamController<String>.broadcast();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneStreamController =
      StreamController<String>.broadcast();
  final StreamController _areAllInputValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserRegisteredInSuccessfullyStreamController =
      StreamController<bool>();

  RegisterObject registerObject = RegisterObject("", "", "", "");

  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  //inputs
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _passwordStreamController.close();
    _emailStreamController.close();
    _areAllInputValidStreamController.close();
    isUserRegisteredInSuccessfullyStreamController.close();
    _nameStreamController.close();
    _phoneStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputAreAllInputsValid => _areAllInputValidStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputName => _nameStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputPhone => _phoneStreamController.sink;

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.email,
            registerObject.password,
            registerObject.name,
            registerObject.phone)))
        .fold(
            (failure) => inputState.add(ErrorState(
                  StateRendererType.popupErrorState,
                  failure.message,
                )), (data) {
      inputState.add(ContentState());
      isUserRegisteredInSuccessfullyStreamController.add(true);
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setName(String name) {
    inputName.add(name);
    if (_isNameValid(name)) {
      registerObject = registerObject.copyWith(name: name);
    } else {
      registerObject = registerObject.copyWith(name: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    if (_isPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    inputAreAllInputsValid.add(null);
  }

  @override
  setPhone(String phone) {
    inputPhone.add(phone);
    if (_isMobileNumberValid(phone)) {
      registerObject = registerObject.copyWith(phone: phone);
    } else {
      registerObject = registerObject.copyWith(phone: "");
    }
    registerObject = registerObject.copyWith(phone: phone);
  }

  //outputs
  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputValidStreamController.stream.map((_) => _areAllInputsValid());

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.invalidEmail);

  @override
  Stream<String?> get outputErrorName => outputIsNameValid
      .map((isNameValid) => isNameValid ? null : AppStrings.nameInvalid);

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordInvalid);

  @override
  Stream<String?> get outputErrorPhone => outputIsPhoneValid.map(
      (isPhoneValid) => isPhoneValid ? null : AppStrings.mobileNumberInvalid);

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outputIsNameValid =>
      _nameStreamController.stream.map((name) => _isNameValid(name));

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsPhoneValid =>
      _phoneStreamController.stream.map((phone) => _isMobileNumberValid(phone));

  // --  private functions

  bool _isNameValid(String name) {
    return name.isNotEmpty;
  }

  bool _isMobileNumberValid(String phone) {
    return phone.length == 11;
  }

  bool _isPasswordValid(String password) {
    return password.length >= 6;
  }

  bool _areAllInputsValid() {
    return registerObject.phone.isNotEmpty &&
        registerObject.name.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty;
  }
}

abstract class RegisterViewModelInput {
  Sink get inputName;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputPhone;

  Sink get inputAreAllInputsValid;

  register();

  setName(String name);

  setEmail(String email);

  setPhone(String phone);

  setPassword(String password);
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsNameValid;

  Stream<String?> get outputErrorName;

  Stream<bool> get outputIsPhoneValid;

  Stream<String?> get outputErrorPhone;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<bool> get outputAreAllInputsValid;
}
