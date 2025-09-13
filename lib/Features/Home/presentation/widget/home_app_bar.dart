import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 40.h, right: 16.w),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RoutePaths.settings);
              },
              child: CircleAvatar(
                radius: 19.r,
                backgroundImage: AssetImage(AssetsPaths.userAvatar),
              ),
            ),
            Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.toNamed(RoutePaths.notifications);
              },
              icon: Icon(
                Icons.notifications,
                color: AppColors.primaryColor,
                size: 35.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
