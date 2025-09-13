import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

class MeetingMembersBody extends StatelessWidget {
  const MeetingMembersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: MemberTile(),
              );
            },
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFDD2DC),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 50.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              child: Text(
                "CancleMeeting".tr(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffCF2D26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  const MemberTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 27.r,
        backgroundImage: AssetImage(AssetsPaths.userAvatar),
      ),
      title: Text(
        "Omar Ahmad",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),

      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20.sp),
          SizedBox(width: 5.w),
          Text(
            "حاضر",
            style: TextStyle(color: Colors.green, fontSize: 18.sp),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(Icons.delete_outline),
        color: AppColors.primaryColor,
        iconSize: 35.sp,
      ),
    );
  }
}
