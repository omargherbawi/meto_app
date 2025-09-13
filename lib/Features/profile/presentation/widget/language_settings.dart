import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Language".tr(),
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 178, 169, 197),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.language_outlined,
              color: AppColors.primaryColor,
              size: 30.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              "Language".tr(),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.authAction,
              ),
            ),
            Spacer(),
            Text(
              "Arabic".tr(),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.authAction,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color.fromARGB(255, 133, 126, 148),
            ),
          ],
        ),
      ],
    );
  }
}
