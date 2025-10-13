import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/profile/domain/repositories/profile_repository.dart';
import 'package:meto_application/core/errors/failures.dart';

class UpdateAvatarUseCase {
  final ProfileRepository repository;
  UpdateAvatarUseCase(this.repository);

  Future<Either<Failure, Profile>> call(Uint8List imageBytes, String fileExtension, String? oldAvatarUrl) async {
    final result = await repository.updateAvatar(imageBytes, fileExtension, oldAvatarUrl);
    
    return result.fold(
      (failure) => Left(failure),
      (avatarUrl) => repository.updateProfileAvatar(avatarUrl),
    );
  }
}
