import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userProfile = authController.profile.value;
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
                radius: 21.r,
                backgroundImage: userProfile?.avatarUrl != null
                    ? NetworkImage(userProfile!.avatarUrl!)
                    : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
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
