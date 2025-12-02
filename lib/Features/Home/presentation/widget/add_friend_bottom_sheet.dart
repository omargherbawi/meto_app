import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/widget/custom_text_form_field.dart';
import '../../../notifications/presentation/controller/friend_request_controller.dart';
import '../controller/friends_controller.dart';

class AddFriendBottomSheet extends StatefulWidget {
  const AddFriendBottomSheet({super.key});

  @override
  State<AddFriendBottomSheet> createState() => _AddFriendBottomSheetState();
}

class _AddFriendBottomSheetState extends State<AddFriendBottomSheet> {
  final TextEditingController searchController = TextEditingController();
  final friendsController = Get.find<FriendsController>();
  final friendRequestController = Get.find<FriendRequestController>();
  
  // Track which users have pending requests
  final Set<String> pendingRequestUserIds = {};

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
            "Add Friend",
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          CustomTextFormField(
            controller: searchController,
            hintText: "Search by name or email",
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            onChanged: (value) {
              if (value.length >= 1) {
                friendsController.searchUsers(value);
              } else {
                friendsController.searchResults.clear();
              }
            },
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Obx(() {
              if (friendsController.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (friendsController.searchResults.isEmpty &&
                  searchController.text.isNotEmpty) {
                return Center(
                  child: Text(
                    "No users found",
                    style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                  ),
                );
              }

              return ListView.separated(
                itemCount: friendsController.searchResults.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final user = friendsController.searchResults[index];
                  final hasPendingRequest = pendingRequestUserIds.contains(user.id);
                  
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user.avatarUrl != null
                          ? CachedNetworkImageProvider(user.avatarUrl!)
                          : AssetImage(AssetsPaths.userAvatar) as ImageProvider,
                    ),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: hasPendingRequest
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12.sp,
                              ),
                            ),
                          )
                        : Obx(() => friendRequestController.isSending.value
                            ? SizedBox(
                                width: 24.w,
                                height: 24.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.person_add,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () async {
                                  final success = await friendRequestController
                                      .sendFriendRequest(user.id);
                                  if (success) {
                                    setState(() {
                                      pendingRequestUserIds.add(user.id);
                                    });
                                  }
                                },
                              )),
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
