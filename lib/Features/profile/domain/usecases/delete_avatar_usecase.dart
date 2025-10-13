import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/profile/domain/repositories/profile_repository.dart';
import 'package:meto_application/core/errors/failures.dart';

class DeleteAvatarUseCase {
  final ProfileRepository repository;
  DeleteAvatarUseCase(this.repository);

  Future<Either<Failure, Profile>> call(String avatarUrl) async {
    final result = await repository.deleteAvatar(avatarUrl);
    
    return result.fold(
      (failure) => Left(failure),
      (_) => repository.updateProfileAvatar(''), // Set empty string to remove avatar
    );
  }
}
