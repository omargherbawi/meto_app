import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/validation/text_field_validation.dart';
import 'package:meto_application/core/widget/custom_text_form_field.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onChangePasswordPressed() {
    if (_formKey.currentState?.validate() ?? false) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'EnterNewPassword'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30.h),

            CustomTextFormField(
              controller: _passwordController,
              validator: TextFieldValidation.validatePassword,
              hintText: 'Password'.tr(),
              labelText: 'NewPassword'.tr(),
              obscureText: !_isPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.primaryColor,
              ),
            ),

            SizedBox(height: 20.h),

            CustomTextFormField(
              controller: _confirmPasswordController,
              validator: (value) => TextFieldValidation.validateConfirmPassword(
                value,
                _passwordController.text,
              ),
              hintText: 'ConfirmPassword'.tr(),
              labelText: 'ConfirmNewPassword'.tr(),
              obscureText: !_isConfirmPasswordVisible,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.primaryColor,
              ),
            ),

            SizedBox(height: 40.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onChangePasswordPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'ChangePassword'.tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
