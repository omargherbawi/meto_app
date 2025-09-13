import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

class MeetingHeader extends StatelessWidget {
  const MeetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: AppColors.primaryColor,
                size: 28.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'April 25, 2025 . 5:00 PM',
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryColor,
                size: 28.sp,
              ),
              SizedBox(width: 8.w),

              Text(
                'Jordan, Amman',
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(height: 5.h),

          Row(
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundImage: AssetImage(AssetsPaths.userAvatar),
              ),
              SizedBox(width: 8.w),

              Text(
                'Created by omar',
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(255, 201, 200, 200),
          ),
        ],
      ),
    );
  }
}
