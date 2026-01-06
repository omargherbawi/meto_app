import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/notifications/presentation/widget/notifications_body.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';
import '../controller/friend_request_controller.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh friend requests when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<FriendRequestController>()) {
        Get.find<FriendRequestController>().loadPendingRequests();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F0FF),
      appBar: CustomAppBar(title: "Notifications"),
      body: NotificationsBody(),
    );
  }
}
