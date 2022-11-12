import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, User> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
