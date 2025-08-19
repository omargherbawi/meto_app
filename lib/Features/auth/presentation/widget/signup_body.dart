import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:meto_application/Features/auth/presentation/widget/auth_text_field.dart';
import 'package:meto_application/Features/auth/presentation/widget/social_button.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/validation/text_field_validation.dart';

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignupPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with signup
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmPasswordController.text}');
      // TODO: Implement actual signup logic here
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
            child: Image.asset(AssetsPaths.signup, fit: BoxFit.cover,),
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
                      'Signup'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    SizedBox(height: 16),
                    AuthTextField(
                      title: 'Name',
                      prefixIcon: Icon(Icons.person_outlined, color: Colors.grey),
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      validator: TextFieldValidation.validateName,
                    ),
                    SizedBox(height: 16),
                    AuthTextField(
                      title: 'Email',
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
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
                    SizedBox(height: 14),
                    AuthTextField(
                      title: 'ConfirmPassword',
                      prefixIcon: const Icon(
                        Icons.lock_outlined,
                        color: Colors.grey,
                      ),
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      validator: (value) => TextFieldValidation.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
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
                      onPressed: _onSignupPressed,
                      child: Text(
                        'Signup'.tr(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'HaveAccount'.tr(),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          'loginNow'.tr(),
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
