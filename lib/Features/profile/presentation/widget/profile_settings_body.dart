import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/widget/custom_confirmation_dialog.dart';
import 'account_settings.dart';
import 'notification_settings.dart';
import 'language_settings.dart';

class ProfleSettingsBody extends StatefulWidget {
  const ProfleSettingsBody({super.key});

  @override
  State<ProfleSettingsBody> createState() => _ProfleSettingsBodyState();
}

class _ProfleSettingsBodyState extends State<ProfleSettingsBody> {
  void _showDeleteAccountConfirmation(BuildContext context) {
    CustomConfirmationDialog.show(
      context: context,
      title: "DeleteAccountConfirmation",
      message: "DeleteAccountWarning",
      confirmText: "Yes",
      cancelText: "No",
      confirmButtonColor: Colors.red,
      onConfirm: () {
        // TODO: Implement actual delete account logic here
        // Example: Clear user data, show loading, navigate to login screen, etc.
        // Get.offAllNamed(RoutePaths.login);
      },
      onCancel: () {},
    );
  }

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
          InkWell(
            onTap: () => _showDeleteAccountConfirmation(context),
            child: Text(
              "DeleteAccount".tr(),
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
