import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/assets_paths.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 67.w),
              Text("Omar"),
            ],
          ),
          SizedBox(height: 4.h),
          Row(
            children: [
              SizedBox(width: 10.w),

              CircleAvatar(
                radius: 16.r,
                backgroundImage: AssetImage(AssetsPaths.userAvatar),
              ),
              SizedBox(width: 10.w),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffE3E2E9),

                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "is this time okay for every one ?",
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
