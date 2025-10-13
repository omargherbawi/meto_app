import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, Profile>> login(String email, String password);
  Future<Either<Failure, Profile>> signup(String email, String password, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, Profile>> getProfile(String userId);
}
