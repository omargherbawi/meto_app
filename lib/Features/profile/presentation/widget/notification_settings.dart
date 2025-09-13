import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notifications".tr(),
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 178, 169, 197),
          ),
        ),
        SizedBox(height: 3.h),
        Row(
          children: [
            Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
              size: 30.sp,
            ),
            SizedBox(width: 10.w),
            Text(
              "MuteNotifications".tr(),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.authAction,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 50.w,
              child: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: AppColors.primaryColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey[300],
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
