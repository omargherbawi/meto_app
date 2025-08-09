import 'package:flutter/material.dart';
import 'package:meto_application/Features/auth/presentation/widget/login_body.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: LoginBody());
  }
}
