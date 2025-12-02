import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service to send push notifications via Supabase Edge Function
class NotificationSenderService {
  static final NotificationSenderService _instance = NotificationSenderService._internal();
  factory NotificationSenderService() => _instance;
  NotificationSenderService._internal();

  final SupabaseClient _client = Supabase.instance.client;

  /// Send a friend request notification to a user
  Future<void> sendFriendRequestNotification({
    required String toUserId,
    required String fromUserName,
    String? fromUserId,
  }) async {
    try {
      // Get the receiver's FCM token
      final response = await _client
          .from('profiles')
          .select('fcm_token')
          .eq('id', toUserId)
          .single();

      final String? fcmToken = response['fcm_token'];

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint('User does not have FCM token, skipping notification');
        return;
      }

      // Call Edge Function to send notification
      await _client.functions.invoke(
        'send-push-notification',
        body: {
          'token': fcmToken,
          'title': 'New Friend Request 👋',
          'body': '$fromUserName sent you a friend request',
          'data': {
            'type': 'friend_request',
            'channel': 'friend_requests',
            if (fromUserId != null) 'from_user_id': fromUserId,
          },
        },
      );

      debugPrint('Friend request notification sent successfully');
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  /// Send a friend request accepted notification
  Future<void> sendFriendAcceptedNotification({
    required String toUserId,
    required String accepterName,
  }) async {
    try {
      final response = await _client
          .from('profiles')
          .select('fcm_token')
          .eq('id', toUserId)
          .single();

      final String? fcmToken = response['fcm_token'];

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint('User does not have FCM token, skipping notification');
        return;
      }

      await _client.functions.invoke(
        'send-push-notification',
        body: {
          'token': fcmToken,
          'title': 'Friend Request Accepted ✅',
          'body': '$accepterName accepted your friend request',
          'data': {
            'type': 'friend_accepted',
            'channel': 'friend_requests',
          },
        },
      );

      debugPrint('Friend accepted notification sent successfully');
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }

  /// Send a generic notification to a user
  Future<void> sendNotification({
    required String toUserId,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      final response = await _client
          .from('profiles')
          .select('fcm_token')
          .eq('id', toUserId)
          .single();

      final String? fcmToken = response['fcm_token'];

      if (fcmToken == null || fcmToken.isEmpty) {
        debugPrint('User does not have FCM token, skipping notification');
        return;
      }

      await _client.functions.invoke(
        'send-push-notification',
        body: {
          'token': fcmToken,
          'title': title,
          'body': body,
          'data': data ?? {'type': 'general', 'channel': 'general'},
        },
      );

      debugPrint('Notification sent successfully');
    } catch (e) {
      debugPrint('Error sending notification: $e');
    }
  }
}
