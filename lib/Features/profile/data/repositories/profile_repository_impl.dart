import 'dart:typed_data';
import 'package:dartz/dartz.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';
import 'package:meto_application/Features/profile/domain/repositories/profile_repository.dart';
import 'package:meto_application/Features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:meto_application/core/errors/failures.dart';
import 'package:meto_application/core/errors/error_handler.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> addAvatar(Uint8List imageBytes, String fileExtension) async {
    return await ErrorHandler.handle(() async {
      return await remoteDataSource.uploadAvatar(imageBytes, fileExtension);
    });
  }

  @override
  Future<Either<Failure, String>> updateAvatar(Uint8List imageBytes, String fileExtension, String? oldAvatarUrl) async {
    return await ErrorHandler.handle(() async {
      // Delete old avatar if exists
      if (oldAvatarUrl != null && oldAvatarUrl.isNotEmpty) {
        try {
          await remoteDataSource.deleteAvatarFromStorage(oldAvatarUrl);
        } catch (e) {
          // Continue with upload even if old file deletion fails
          print('Failed to delete old avatar: $e');
        }
      }
      
      // Upload new avatar
      return await remoteDataSource.uploadAvatar(imageBytes, fileExtension);
    });
  }

  @override
  Future<Either<Failure, void>> deleteAvatar(String avatarUrl) async {
    return await ErrorHandler.handle(() async {
      await remoteDataSource.deleteAvatarFromStorage(avatarUrl);
    });
  }

  @override
  Future<Either<Failure, Profile>> updateProfileAvatar(String avatarUrl) async {
    return await ErrorHandler.handle(() async {
      return await remoteDataSource.updateProfileAvatar(avatarUrl);
    });
  }
}
