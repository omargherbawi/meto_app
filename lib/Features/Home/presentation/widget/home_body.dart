import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/Features/Home/presentation/widget/home_app_bar.dart';
import 'package:meto_application/Features/Home/presentation/widget/home_meeting_item.dart';
import 'package:meto_application/config/app_colors.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeAppBar(),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 30.h),
              child: Text(
                'YourMeetings'.tr(),
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: AppColors.primaryColor,
                  size: 35.sp,
                ),
              ),
            ),
          ],
        ),
        HomeMeetingsItem(),
      ],
    );
  }
}
