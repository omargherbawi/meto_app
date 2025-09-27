import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/auth/domain/repositories/auth_repository.dart';
import 'package:meto_application/core/errors/failures.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<Either<Failure, Profile>> call(String email, String password, String name) {
    return repository.signup(email, password, name);
  }
}
