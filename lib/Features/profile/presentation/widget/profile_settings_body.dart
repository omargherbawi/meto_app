import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'account_settings.dart';
import 'notification_settings.dart';
import 'language_settings.dart';

class ProfleSettingsBody extends StatefulWidget {
  const ProfleSettingsBody({super.key});

  @override
  State<ProfleSettingsBody> createState() => _ProfleSettingsBodyState();
}

class _ProfleSettingsBodyState extends State<ProfleSettingsBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: (Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Settings".tr(),
            style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.authAction,
            ),
          ),
          SizedBox(height: 5.h),
          AcountSettings(),
          NotificationSettings(),
          LanguageSettings(),
          SizedBox(height: 23.h),
          Text(
            "DeleteAccount".tr(),
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      )),
    );
  }
}
