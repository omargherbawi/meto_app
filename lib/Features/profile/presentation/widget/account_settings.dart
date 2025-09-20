import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:meto_application/Features/profile/presentation/widget/profile_avatar_edit.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/widget/custom_confirmation_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class AcountSettings extends StatelessWidget {
  const AcountSettings({super.key});

  void _showLogoutConfirmation(BuildContext context) {
    CustomConfirmationDialog.show(
      context: context,
      title: "LogoutConfirmation",
      message: "LogoutConfirmation",
      confirmText: "Yes",
      cancelText: "No",
      confirmButtonColor: Colors.red,
      onConfirm: () {
        // TODO: Implement actual logout logic here
        print('User confirmed logout');
        // Example: Clear user data, navigate to login screen, etc.
        // Get.offAllNamed(RoutePaths.login);
      },
      onCancel: () {
        print('User cancelled logout');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account".tr(),
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 178, 169, 197),
          ),
        ),
        Center(child: AvatarPickerWidget()),
        SizedBox(height: 10.h),

        AcountSettingsRow(
          subtitle: "FullName".tr(),
          value: 'Omar Ahmad',
          hideIcon: true,
        ),
        AcountSettingsRow(
          subtitle: "Email".tr(),
          value: 'q6VcM@example.com',
          hideIcon: true,
        ),
        AcountSettingsRow(
          subtitle: "ChangePassword".tr(),
          value: '',
          onTap: () => Get.toNamed(RoutePaths.changePassword),
        ),
        AcountSettingsRow(
          subtitle: "SignOut".tr(),
          value: '',
          isLast: true,
          onTap: () => _showLogoutConfirmation(context),
          icon: const Icon(
            Icons.logout_outlined,
            size: 24,
            color: Color.fromARGB(255, 133, 126, 148),
          ),
        ),
      ],
    );
  }
}

class AcountSettingsRow extends StatelessWidget {
  const AcountSettingsRow({
    super.key,
    required this.subtitle,
    required this.value,
    this.isLast = false,
    this.hideIcon = false,
    this.icon = const Icon(
      Icons.arrow_forward_ios,
      size: 18,
      color: Color.fromARGB(255, 133, 126, 148),
    ),
    this.onTap,
  });

  final String subtitle;
  final String value;
  final bool isLast;
  final bool hideIcon;
  final Icon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.authAction,
                  ),
                ),
                Spacer(),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.authAction,
                  ),
                ),
                SizedBox(width: 10.w),
                if (!hideIcon) icon,
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        isLast
            ? const Divider(color: Colors.transparent)
            : Divider(color: Color(0xffEDF0F7), thickness: 2.h),
      ],
    );
  }
}
