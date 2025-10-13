import 'package:dartz/dartz.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/profile_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, Profile>> login(String email, String password) async {
    return await ErrorHandler.handle(() async {
      final authResponse = await remote.login(email, password);
      if (authResponse.user == null) {
        throw const AuthFailure('Invalidcredentials,pleasecheckyourphoneNumberorpassword');
      }
      
      final profile = await remote.getProfile(authResponse.user!.id);
      if (profile == null) {
        throw const AuthFailure('profile_not_found');
      }
      
      return profile;
    });
  }

  @override
  Future<Either<Failure, Profile>> signup(String email, String password, String name) async {
    return await ErrorHandler.handle(() async {
      final authResponse = await remote.signup(email, password);
      if (authResponse.user == null) {
        throw const AuthFailure('signup_failed');
      }

      final profile = ProfileModel(
        id: authResponse.user!.id,
        email: email,
        name: name,
      );

      try {
        await remote.createProfile(profile);
      } catch (e) {
        // If profile creation fails due to RLS, we can still proceed
        // The user is authenticated and can retry profile creation later
        print('Profile creation failed (possibly due to RLS): $e');
      }
      
      return profile;
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return await ErrorHandler.handle(() async {
      await remote.logout();
    });
  }

  @override
  Future<Either<Failure, Profile>> getProfile(String userId) async {
    return await ErrorHandler.handle(() async {
      final profile = await remote.getProfile(userId);
      if (profile == null) {
        throw const AuthFailure('profile_not_found');
      }
      return profile;
    });
  }
}
