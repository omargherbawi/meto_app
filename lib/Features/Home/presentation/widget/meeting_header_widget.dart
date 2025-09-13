import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';

class MeetingHeaderWidget extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String title;

  const MeetingHeaderWidget({
    super.key,
    required this.onSave,
    required this.onCancel,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        top: 12.h,
        bottom: 20.h,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSave,
            child: Text(
              'Save'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const Spacer(),
          Text(
            title.tr(),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onCancel,
            child: Text(
              'Cancel'.tr(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
