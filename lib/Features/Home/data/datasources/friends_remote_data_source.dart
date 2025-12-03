import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/supabase_logger.dart';
import '../../../auth/data/models/profile_model.dart';

class FriendsRemoteDataSource {
  final SupabaseClient client;

  FriendsRemoteDataSource(this.client);

  Future<List<ProfileModel>> getFriends(String userId) async {
    // Join with profiles table using the foreign key relationship
    // The 'profiles' alias refers to the friend_id -> profiles.id relationship
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'friends',
      () => client
          .from('friends')
          .select('friend_id, profiles!friends_friend_id_fkey(*)')
          .eq('user_id', userId),
      data: {'user_id': userId},
    );

    final List<dynamic> data = response as List<dynamic>;
    return data.map((item) {
      // The joined profile data is in the 'profiles' key
      return ProfileModel.fromJson(item['profiles']);
    }).toList();
  }

  Future<void> addFriend(String userId, String friendId) async {
    // Add bidirectional friendship: both users become friends with each other
    await SupabaseLogger.logDatabaseOperation(
      'INSERT',
      'friends',
      () => client.from('friends').insert([
        {
        'user_id': userId,
        'friend_id': friendId,
        },
        {
          'user_id': friendId,
          'friend_id': userId,
        },
      ]),
      data: {'user_id': userId, 'friend_id': friendId},
    );
  }

  Future<void> removeFriend(String userId, String friendId) async {
    // Remove bidirectional friendship: remove from both sides
    await SupabaseLogger.logDatabaseOperation(
      'DELETE',
      'friends',
      () => client
          .from('friends')
          .delete()
          .or('and(user_id.eq.$userId,friend_id.eq.$friendId),and(user_id.eq.$friendId,friend_id.eq.$userId)'),
      data: {'user_id': userId, 'friend_id': friendId},
    );
  }

  Future<List<ProfileModel>> searchUsers(String query) async {
    // Search in profiles table by email or name
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'profiles',
      () => client
          .from('profiles')
          .select()
          .or('email.ilike.%$query%,name.ilike.%$query%')
          .limit(20),
      data: {'query': query},
    );

    final List<dynamic> data = response as List<dynamic>;
    return data.map((item) => ProfileModel.fromJson(item)).toList();
  }
}
