import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import '../screens/friends_screen.dart';

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
                radius: 20.r,
                backgroundImage: userProfile?.avatarUrl != null
                    ? CachedNetworkImageProvider(userProfile!.avatarUrl!)
                    : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
              ),
            ),
            Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Get.to(() => const FriendsScreen());
              },
              icon: FaIcon(
                FontAwesomeIcons.userGroup,
                color: AppColors.primaryColor,
                size: 25.sp,
              ),
            ),
            SizedBox(width: 10.w),
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
