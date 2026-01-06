import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/app_colors.dart';
import '../routes/route_paths.dart';

import 'package:meto_application/firebase_options.dart';
import '../../Features/notifications/presentation/controller/friend_request_controller.dart';

class PushNotificationService {
  static final PushNotificationService _instance = PushNotificationService._internal();
  factory PushNotificationService() => _instance;
  PushNotificationService._internal();

  /// Initialize all notification services
  static Future<void> initialize() async {
    // Initialize Firebase first
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      // Set the icon to null to use the default app icon
      null,
      [
        NotificationChannel(
          channelKey: 'friend_requests',
          channelName: 'Friend Requests',
          channelDescription: 'Notifications for friend requests',
          defaultColor: AppColors.primaryColor,
          ledColor: AppColors.primaryColor,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
          enableVibration: true,
        ),
        NotificationChannel(
          channelKey: 'general',
          channelName: 'General Notifications',
          channelDescription: 'General app notifications',
          defaultColor: AppColors.primaryColor,
          ledColor: AppColors.primaryColor,
          importance: NotificationImportance.Default,
          channelShowBadge: true,
        ),
      ],
      debug: true,
    );

    // Initialize FCM
    await AwesomeNotificationsFcm().initialize(
      onFcmSilentDataHandle: _onFcmSilentDataHandle,
      onFcmTokenHandle: _onFcmTokenHandle,
      onNativeTokenHandle: _onNativeTokenHandle,
      debug: true,
    );

    // Set up notification listeners
    _setupListeners();

    // Request permission
    await requestPermission();
  }

  /// Request notification permission
  static Future<bool> requestPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
    }
    return isAllowed;
  }

  /// Set up notification action listeners
  static void _setupListeners() {
    // Listen to notification creation
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreatedMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
  }

  /// Refresh friend requests when notifications are received
  static void _refreshFriendRequests() {
    try {
      if (Get.isRegistered<FriendRequestController>()) {
        Get.find<FriendRequestController>().loadPendingRequests();
        debugPrint('Friend requests refreshed');
      }
    } catch (e) {
      debugPrint('Error refreshing friend requests: $e');
    }
  }

  /// Called when user taps on notification
  @pragma('vm:entry-point')
  static Future<void> _onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('Notification action received: ${receivedAction.payload}');

    final String? type = receivedAction.payload?['type'];

    // Refresh friend requests data
    _refreshFriendRequests();

    // Navigate based on notification type
    switch (type) {
      case 'friend_request':
        Get.toNamed(RoutePaths.notifications);
        break;
      case 'friend_accepted':
        Get.toNamed(RoutePaths.notifications);
        break;
      default:
        Get.toNamed(RoutePaths.notifications);
    }
  }

  /// Called when notification is created
  @pragma('vm:entry-point')
  static Future<void> _onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('Notification created: ${receivedNotification.id}');
    
    // Refresh friend requests when friend request notifications are created
    final String? type = receivedNotification.payload?['type'];
    if (type == 'friend_request' || type == 'friend_accepted') {
      _refreshFriendRequests();
    }
  }

  /// Called when notification is displayed
  @pragma('vm:entry-point')
  static Future<void> _onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {
    debugPrint('Notification displayed: ${receivedNotification.id}');
  }

  /// Called when notification is dismissed
  @pragma('vm:entry-point')
  static Future<void> _onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('Notification dismissed: ${receivedAction.id}');
  }

  /// Handle silent FCM data (background)
  @pragma('vm:entry-point')
  static Future<void> _onFcmSilentDataHandle(FcmSilentData silentData) async {
    debugPrint('Silent FCM data received: ${silentData.data}');

    // Create a local notification from the silent data
    if (silentData.data != null) {
      final data = silentData.data!;
      
      // Refresh friend requests if this is a friend-related notification
      final String? type = data['type']?.toString();
      if (type == 'friend_request' || type == 'friend_accepted') {
        _refreshFriendRequests();
      }
      
      // Convert Map<String, dynamic> to Map<String, String>
      final payload = data.map((key, value) => MapEntry(key, value.toString()));
      await showNotification(
        title: data['title']?.toString() ?? 'New Notification',
        body: data['body']?.toString() ?? '',
        payload: payload,
        channelKey: data['channel']?.toString() ?? 'general',
      );
    }
  }

  /// Handle FCM token
  @pragma('vm:entry-point')
  static Future<void> _onFcmTokenHandle(String token) async {
    debugPrint('FCM Token received: $token');
    await _saveTokenToDatabase(token);
  }

  /// Handle native token (APNs for iOS)
  @pragma('vm:entry-point')
  static Future<void> _onNativeTokenHandle(String token) async {
    debugPrint('Native Token received: $token');
  }

  /// Save FCM token to Supabase
  static Future<void> _saveTokenToDatabase(String token) async {
    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client
            .from('profiles')
            .update({'fcm_token': token})
            .eq('id', user.id);
        debugPrint('FCM token saved to database');
      }
    } catch (e) {
      debugPrint('Error saving FCM token: $e');
    }
  }

  /// Get current FCM token
  static Future<String?> getToken() async {
    return await AwesomeNotificationsFcm().requestFirebaseAppToken();
  }

  /// Request and save token for current user
  static Future<void> requestAndSaveToken() async {
    final token = await getToken();
    if (token != null) {
      await _saveTokenToDatabase(token);
    }
  }

  /// Show a local notification
  static Future<void> showNotification({
    required String title,
    required String body,
    Map<String, String>? payload,
    String channelKey = 'general',
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey,
        title: title,
        body: body,
        payload: payload,
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
      ),
    );
  }

  /// Show friend request notification
  static Future<void> showFriendRequestNotification({
    required String fromUserName,
    String? fromUserId,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'friend_requests',
        title: 'New Friend Request 👋',
        body: '$fromUserName sent you a friend request',
        payload: {
          'type': 'friend_request',
          if (fromUserId != null) 'from_user_id': fromUserId,
        },
        notificationLayout: NotificationLayout.Default,
        wakeUpScreen: true,
        category: NotificationCategory.Social,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'ACCEPT',
          label: 'Accept',
          actionType: ActionType.Default,
        ),
        NotificationActionButton(
          key: 'REJECT',
          label: 'Reject',
          actionType: ActionType.Default,
          isDangerousOption: true,
        ),
      ],
    );
  }

  /// Show friend accepted notification
  static Future<void> showFriendAcceptedNotification({
    required String accepterName,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'friend_requests',
        title: 'Friend Request Accepted ✅',
        body: '$accepterName accepted your friend request',
        payload: {'type': 'friend_accepted'},
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Social,
      ),
    );
  }

  /// Subscribe to a topic
  static Future<void> subscribeToTopic(String topic) async {
    await AwesomeNotificationsFcm().subscribeToTopic(topic);
  }

  /// Unsubscribe from a topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    await AwesomeNotificationsFcm().unsubscribeToTopic(topic);
  }

  /// Cancel all notifications
  static Future<void> cancelAll() async {
    await AwesomeNotifications().cancelAll();
  }

  /// Get badge count
  static Future<int> getBadgeCount() async {
    return await AwesomeNotifications().getGlobalBadgeCounter();
  }

  /// Set badge count
  static Future<void> setBadgeCount(int count) async {
    await AwesomeNotifications().setGlobalBadgeCounter(count);
  }

  /// Reset badge count
  static Future<void> resetBadgeCount() async {
    await AwesomeNotifications().resetGlobalBadge();
  }
}
