import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

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
