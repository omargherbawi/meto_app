import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/config/assets_paths.dart';
import 'package:meto_application/core/widget/custom_text_form_field.dart';

class MeetingSendInviteWidget extends StatelessWidget {
  final bool isLinkSelected;
  final VoidCallback onLinkSelected;
  final VoidCallback onFriendsSelected;
  final VoidCallback onCopyLink;
  final String inviteLink;
  final List<String> friends;
  final Set<String> selectedFriends;
  final Function(String, bool?) onFriendSelectionChanged;

  const MeetingSendInviteWidget({
    super.key,
    required this.isLinkSelected,
    required this.onLinkSelected,
    required this.onFriendsSelected,
    required this.onCopyLink,
    required this.inviteLink,
    required this.friends,
    required this.selectedFriends,
    required this.onFriendSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: Row(
            children: [
              Text(
                'Sendinvitevia'.tr(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onLinkSelected,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: isLinkSelected
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(17.r),
                    ),
                    child: Text(
                      'Sendvialink'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isLinkSelected ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onFriendsSelected,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: !isLinkSelected
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(17.r),
                    ),
                    child: Text(
                      'Invitefriends'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !isLinkSelected ? Colors.white : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),

        if (isLinkSelected) ...[
          CustomTextFormField(
            controller: TextEditingController(text: inviteLink),
            hintText: "Invite Link",
            suffixIcon: GestureDetector(
              onTap: onCopyLink,
              child: Icon(
                Icons.copy,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
          ),
        ] else ...[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: friends.map((friend) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AssetsPaths.userAvatar),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          friend,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: selectedFriends.contains(friend),
                        onChanged: (bool? value) {
                          onFriendSelectionChanged(friend, value);
                        },
                        activeColor: AppColors.primaryColor,
                        checkColor: Colors.white,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],

        SizedBox(height: 30.h),
      ],
    );
  }
}
