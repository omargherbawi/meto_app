import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/widget/custom_text_form_field.dart';
import '../controller/friends_controller.dart';

class AddFriendBottomSheet extends StatefulWidget {
  const AddFriendBottomSheet({super.key});

  @override
  State<AddFriendBottomSheet> createState() => _AddFriendBottomSheetState();
}

class _AddFriendBottomSheetState extends State<AddFriendBottomSheet> {
  final TextEditingController searchController = TextEditingController();
  final controller = Get.find<FriendsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.8.sh,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            "AddFriend".tr(),
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: searchController,
            hintText: "SearchByNameOrEmail".tr(),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            onChanged: (value) {
              // Debounce search could be added here
              if (value.length >= 1) {
                controller.searchUsers(value);
              } else {
                controller.searchResults.clear();
              }
            },
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Obx(() {
              if (controller.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.searchResults.isEmpty &&
                  searchController.text.isNotEmpty) {
                return Center(
                  child: Text(
                    "NoUsersFound".tr(),
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                );
              }

              return ListView.separated(
                itemCount: controller.searchResults.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final user = controller.searchResults[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.avatarUrl != null
                          ? CachedNetworkImageProvider(user.avatarUrl!)
                          : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.person_add,
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        controller.addFriend(user.id);
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
