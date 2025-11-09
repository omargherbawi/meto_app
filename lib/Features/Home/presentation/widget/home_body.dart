import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/Home/presentation/controller/home_controller.dart';
import 'package:meto_application/Features/Home/presentation/widget/create_meeting_bottom_sheet.dart';
import 'package:meto_application/Features/Home/presentation/widget/home_app_bar.dart';
import 'package:meto_application/Features/Home/presentation/widget/home_meeting_item.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/config/app_colors.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late final HomeController homeController;
  late final AuthController authController;
  Worker? profileWorker;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    authController = Get.find<AuthController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = authController.profile.value?.id;
      if (userId != null) {
        homeController.loadMeetings(userId);
      }
    });

    profileWorker = ever(authController.profile, (profile) {
      final userId = profile?.id;
      if (userId != null) {
        homeController.loadMeetings(userId);
      }
    });
  }

  @override
  void dispose() {
    profileWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: HomeAppBar()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 20.w,
              top: 18.h,
              bottom: 4.h,
            ),
            child: Row(
              children: [
                Text(
                  ez.tr('YourMeetings'),
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const CreateMeetingBottomSheet(),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                    size: 35.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() {
          if (homeController.isLoadingMeetings.value) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          final meetings = homeController.meetings;

          if (meetings.isEmpty) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: Text(
                    ez.tr('NoMeetingsYet'),
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => HomeMeetingsItem(meeting: meetings[index]),
              childCount: meetings.length,
            ),
          );
        }),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
      ],
    );
  }
}
