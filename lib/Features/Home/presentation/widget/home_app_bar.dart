import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundImage: AssetImage(AssetsPaths.userAvatar),
            ),
            Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
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
