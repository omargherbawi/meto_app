import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meto_application/Features/auth/presentation/widget/auth_text_field.dart';
import 'package:meto_application/Features/auth/presentation/widget/social_button.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/validation/text_field_validation.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  void _onLoginPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with login
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // TODO: Implement actual login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            child: Image.asset(AssetsPaths.login, fit: BoxFit.cover),
          ),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.67,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Login'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(height: 16),
                    AuthTextField(
                      title: 'Email',
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: TextFieldValidation.validateEmail,
                    ),
                    SizedBox(height: 14),
                    AuthTextField(
                      title: 'Password',
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                        color: Colors.grey,
                      ),
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      controller: _passwordController,
                      validator: TextFieldValidation.validatePassword,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.authAction,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: _onLoginPressed,
                      child: Text(
                        'Login'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "forgotPassword".tr(),
                      style: TextStyle(
                        color: AppColors.secondry,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dontHaveAccount'.tr(),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutePaths.signup);
                        },
                        child: Text(
                          'RegisterNow'.tr(),
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.secondry,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR'.tr(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SocialButton(
                    text: 'Google',
                    iconPath: AssetsPaths.google,
                    backgroundColor: AppColors.authAction,
                    onPressed: () {},
                  ),
                  SizedBox(height: 12),
                  SocialButton(
                    text: 'Facebook'.tr(),
                    iconPath: AssetsPaths.facebook,
                    backgroundColor: AppColors.authAction,
                    onPressed: () {},
                  ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
