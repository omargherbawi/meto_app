import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/supabase_logger.dart';
import '../models/friend_request_model.dart';

class FriendRequestRemoteDataSource {
  final SupabaseClient client;

  FriendRequestRemoteDataSource(this.client);

  /// Get all pending friend requests received by the user
  Future<List<FriendRequestModel>> getPendingRequests(String userId) async {
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'friend_requests',
      () => client
          .from('friend_requests')
          .select('*, from_user:from_user_id(*)')
          .eq('to_user_id', userId)
          .eq('status', 'pending')
          .order('created_at', ascending: false),
      data: {'to_user_id': userId},
    );

    final List<dynamic> data = response as List<dynamic>;
    return data.map((item) => FriendRequestModel.fromJson(item)).toList();
  }

  /// Get all friend requests sent by the user
  Future<List<FriendRequestModel>> getSentRequests(String userId) async {
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'friend_requests',
      () => client
          .from('friend_requests')
          .select('*, to_user:to_user_id(*)')
          .eq('from_user_id', userId)
          .eq('status', 'pending')
          .order('created_at', ascending: false),
      data: {'from_user_id': userId},
    );

    final List<dynamic> data = response as List<dynamic>;
    return data.map((item) => FriendRequestModel.fromJson(item)).toList();
  }

  /// Send a friend request
  Future<void> sendFriendRequest(String fromUserId, String toUserId) async {
    await SupabaseLogger.logDatabaseOperation(
      'INSERT',
      'friend_requests',
      () => client.from('friend_requests').insert({
        'from_user_id': fromUserId,
        'to_user_id': toUserId,
        'status': 'pending',
      }),
      data: {'from_user_id': fromUserId, 'to_user_id': toUserId},
    );
  }

  /// Accept a friend request
  Future<void> acceptFriendRequest(String requestId) async {
    await SupabaseLogger.logDatabaseOperation(
      'UPDATE',
      'friend_requests',
      () => client
          .from('friend_requests')
          .update({'status': 'accepted'})
          .eq('id', requestId),
      data: {'request_id': requestId, 'status': 'accepted'},
    );
  }

  /// Reject a friend request
  Future<void> rejectFriendRequest(String requestId) async {
    await SupabaseLogger.logDatabaseOperation(
      'UPDATE',
      'friend_requests',
      () => client
          .from('friend_requests')
          .update({'status': 'rejected'})
          .eq('id', requestId),
      data: {'request_id': requestId, 'status': 'rejected'},
    );
  }

  /// Cancel a sent friend request
  Future<void> cancelFriendRequest(String requestId) async {
    await SupabaseLogger.logDatabaseOperation(
      'DELETE',
      'friend_requests',
      () => client.from('friend_requests').delete().eq('id', requestId),
      data: {'request_id': requestId},
    );
  }

  /// Check if a friend request already exists between two users
  Future<bool> checkExistingRequest(String fromUserId, String toUserId) async {
    final response = await SupabaseLogger.logDatabaseOperation(
      'SELECT',
      'friend_requests',
      () => client
          .from('friend_requests')
          .select('id')
          .or('and(from_user_id.eq.$fromUserId,to_user_id.eq.$toUserId),and(from_user_id.eq.$toUserId,to_user_id.eq.$fromUserId)')
          .eq('status', 'pending'),
      data: {'from_user_id': fromUserId, 'to_user_id': toUserId},
    );

    final List<dynamic> data = response as List<dynamic>;
    return data.isNotEmpty;
  }
}

