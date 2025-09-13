import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/Features/profile/presentation/widget/profile_avatar_edit.dart';
import 'package:meto_application/config/app_colors.dart';

class AcountSettings extends StatelessWidget {
  const AcountSettings({super.key});

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

        AcountSettingsRow(subtitle: "FullName", value: 'Omar Ahmad'),
        AcountSettingsRow(subtitle: "Email", value: 'q6VcM@example.com'),
        AcountSettingsRow(subtitle: "ChangePassword", value: ''),
        AcountSettingsRow(
          subtitle: "SignOut",
          value: '',
          isLast: true,
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
    this.icon = const Icon(
      Icons.arrow_forward_ios,
      size: 18,
      color: Color.fromARGB(255, 133, 126, 148),
    ),
  });

  final String subtitle;
  final String value;
  final bool isLast;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                subtitle.tr(),
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
              icon,
            ],
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
