import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meto_application/Features/auth/presentation/widget/auth_text_field.dart';
import 'package:meto_application/Features/auth/presentation/widget/social_button.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            width: double.infinity,
            child: Image.asset(AssetsPaths.login, fit: BoxFit.cover),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
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
                      onPressed: () {},
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
                          onTap: () {},
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
