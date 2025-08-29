import 'package:flutter/material.dart';
import 'package:meto_application/Features/auth/presentation/widget/forgot_password_body.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ResetPassword"),
      body: ForgotPasswordBody(),
    );
  }
}
