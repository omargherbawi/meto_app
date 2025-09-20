import 'package:flutter/material.dart';
import 'package:meto_application/Features/profile/presentation/widget/change_password_body.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ChangePassword"),
      body: const ChangePasswordBody(),
    );
  }
}
