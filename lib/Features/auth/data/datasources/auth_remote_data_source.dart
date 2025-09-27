import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/supabase_logger.dart';
import '../models/profile_model.dart';

class AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSource(this.client);

  Future<AuthResponse> login(String email, String password) async {
    return await SupabaseLogger.logAuthOperation(
      'LOGIN',
      () => client.auth.signInWithPassword(email: email, password: password),
    );
  }

  Future<AuthResponse> signup(String email, String password) async {
    return await SupabaseLogger.logAuthOperation(
      'SIGNUP',
      () => client.auth.signUp(email: email, password: password),
    );
  }

  Future<void> logout() async {
    await SupabaseLogger.logAuthOperation('LOGOUT', () async {
      await client.auth.signOut();
      return AuthResponse(); // Dummy response for logout
    });
  }

  Future<ProfileModel?> getProfile(String userId) async {
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'profiles',
      () => client.from('profiles').select().eq('id', userId).maybeSingle(),
      data: {'user_id': userId},
    );

    if (response == null) return null;
    return ProfileModel.fromJson(response);
  }

  Future<void> createProfile(ProfileModel profile) async {
    await SupabaseLogger.logDatabaseOperation(
      'UPSERT',
      'profiles',
      () => client.from('profiles').upsert(profile.toJson()),
      data: profile.toJson(),
    );
  }
}
