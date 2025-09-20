import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              "Language".tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.authAction,
              ),
            ),
            SizedBox(height: 20.h),

            // Language options
            _buildLanguageOption(
              context: context,
              languageName: "English",
              locale: Locale('en'),
            ),
            SizedBox(height: 15.h),
            _buildLanguageOption(
              context: context,
              languageName: "Arabic",
              locale: Locale('ar'),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageName,
    required Locale locale,
  }) {
    final currentLocale = context.locale;
    final isSelected = currentLocale.languageCode == locale.languageCode;

    return InkWell(
      onTap: () {
        context.setLocale(locale);
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey[200]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              languageName.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.authAction,
              ),
            ),
            Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primaryColor,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

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
        InkWell(
          onTap: () => _showLanguageBottomSheet(context),
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
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
                  context.locale.languageCode == 'ar'
                      ? "Arabic".tr()
                      : "English".tr(),
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
          ),
        ),
      ],
    );
  }
}
