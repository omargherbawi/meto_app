import 'package:flutter/material.dart';
import 'package:meto_application/Features/notifications/presentation/widget/notifications_body.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF4F0FF),
      appBar: CustomAppBar(title: "Notifications"),
      body: NotificationsBody(),
    );
  }
}
