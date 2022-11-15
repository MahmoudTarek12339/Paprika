import 'package:dartz/dartz.dart';

import 'package:paprika/data/network/failure.dart';

import '../../data/network/requests.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class RegisterUseCase implements BaseUseCase<RegisterUseCaseInput, User> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(RegisterUseCaseInput input) async {
    return await _repository.register(
        RegisterRequest(input.email, input.password, input.name, input.phone));
  }
}

class RegisterUseCaseInput {
  String email;
  String password;
  String name;
  String phone;

  RegisterUseCaseInput(this.email, this.password, this.name, this.phone);
}
