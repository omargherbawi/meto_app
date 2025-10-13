import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/core/errors/failures.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> addAvatar(Uint8List imageBytes, String fileExtension);
  Future<Either<Failure, String>> updateAvatar(Uint8List imageBytes, String fileExtension, String? oldAvatarUrl);
  Future<Either<Failure, void>> deleteAvatar(String avatarUrl);
  Future<Either<Failure, Profile>> updateProfileAvatar(String avatarUrl);
}
