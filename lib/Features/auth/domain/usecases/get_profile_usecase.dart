import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/auth/domain/repositories/auth_repository.dart';
import 'package:meto_application/core/errors/failures.dart';

class GetProfileUseCase {
  final AuthRepository repository;
  GetProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call(String userId) {
    return repository.getProfile(userId);
  }
}

