import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meto_application/Features/auth/presentation/widget/forgot_password_body.dart';
import 'package:meto_application/config/app_colors.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: 
          IconButton(onPressed: (){
            Get.back();
          },
           icon: Icon(Icons.arrow_back_ios_new , color: AppColors.white,))
        ,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "ResetPassword".tr(),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ForgotPasswordBody(),
    );
  }
}
