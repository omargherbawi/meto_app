import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:meto_application/Features/auth/domain/entities/profile.dart';

class ProfileRemoteDataSource {
  final SupabaseClient client;
  ProfileRemoteDataSource(this.client);

  Future<String> uploadAvatar(Uint8List imageBytes, String fileExtension) async {
    final fileName = '${DateTime.now().toIso8601String()}.$fileExtension';
    
    await client.storage.from('avatars').uploadBinary(
      fileName,
      imageBytes,
      fileOptions: FileOptions(
        contentType: 'image/$fileExtension',
      ),
    );

    return client.storage.from('avatars').getPublicUrl(fileName);
  }

  Future<void> deleteAvatarFromStorage(String avatarUrl) async {
    // Extract filename from URL
    final uri = Uri.parse(avatarUrl);
    final pathSegments = uri.pathSegments;
    final fileName = pathSegments.last;
    
    await client.storage.from('avatars').remove([fileName]);
  }

  Future<Profile> updateProfileAvatar(String avatarUrl) async {
    final userId = client.auth.currentUser!.id;
    
    // Update profile in database
    await client
        .from('profiles')
        .update({'avatar_url': avatarUrl.isEmpty ? null : avatarUrl})
        .eq('id', userId);

    // Fetch updated profile
    final response = await client
        .from('profiles')
        .select()
        .eq('id', userId)
        .single();

    return Profile(
      id: response['id'],
      email: response['email'] ?? '',
      name: response['name'] ?? '',
      avatarUrl: response['avatar_url'],
    );
  }
}
