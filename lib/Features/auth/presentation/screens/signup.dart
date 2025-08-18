import 'package:flutter/material.dart';
import 'package:meto_application/Features/auth/presentation/widget/signup_body.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: SignupBody());
  }
}
