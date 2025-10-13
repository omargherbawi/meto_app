import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/profile/domain/repositories/profile_repository.dart';
import 'package:meto_application/core/errors/failures.dart';

class AddAvatarUseCase {
  final ProfileRepository repository;
  AddAvatarUseCase(this.repository);

  Future<Either<Failure, Profile>> call(Uint8List imageBytes, String fileExtension) async {
    final result = await repository.addAvatar(imageBytes, fileExtension);
    
    return result.fold(
      (failure) => Left(failure),
      (avatarUrl) => repository.updateProfileAvatar(avatarUrl),
    );
  }
}
