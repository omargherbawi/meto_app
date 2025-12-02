import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';
import '../controller/friends_controller.dart';
import '../widget/add_friend_bottom_sheet.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FriendsController>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Friends",
        backgroundColor: Colors.white,
        leadingIconColor: AppColors.primaryColor,
        systemUI: SystemUiOverlayStyle.dark,
        tilteSytle: TextStyle(
          color: Colors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.bottomSheet(
                const AddFriendBottomSheet(),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              );
            },
            icon: Icon(Icons.add, color: AppColors.primaryColor, size: 34.sp),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.friends.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people_outline, size: 80.sp, color: Colors.grey),
                SizedBox(height: 16.h),
                Text(
                  "NoFriendsYet".tr(),
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () {
                    Get.bottomSheet(
                      const AddFriendBottomSheet(),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Text(
                    "AddAFriend".tr(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: controller.friends.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final friend = controller.friends[index];
            return Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: friend.avatarUrl != null
                        ? CachedNetworkImageProvider(friend.avatarUrl!)
                        : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friend.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          friend.email,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.defaultDialog(
                        title: "RemoveFriend".tr(),
                        middleText:
                            "RemoveFriendConfirmation".tr().replaceAll("{name}", friend.name),
                        textConfirm: "Remove".tr(),
                        textCancel: "Cancel".tr(),
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          controller.removeFriend(friend.id);
                          Get.back();
                        },
                      );
                    },
                    icon: Icon(Icons.person_remove, color: Colors.red),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
