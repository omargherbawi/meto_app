import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/Features/meetings/presentation/widget/add_members_bottom_sheet.dart';
import 'package:meto_application/Features/meetings/presentation/widget/meeting_members_body.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class MeetingMembers extends StatelessWidget {
  const MeetingMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const AddMembersBottomSheet(),
              );
            },
            icon: Icon(Icons.add, color: AppColors.primaryColor, size: 32.sp),
          ),
        ],
        leadingIconColor: AppColors.primaryColor,
        title: "Members",
        backgroundColor: Colors.white,
        tilteSytle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: MeetingMembersBody(),
    );
  }
}
