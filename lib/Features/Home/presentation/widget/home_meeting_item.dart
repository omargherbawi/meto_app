import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meto_application/Features/Home/domain/entities/meeting.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:meto_application/core/routes/route_paths.dart';

class HomeMeetingsItem extends StatelessWidget {
  const HomeMeetingsItem({
    super.key,
    required this.meeting,
  });

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    final meetingDate = meeting.date ?? meeting.meetingTime;
    final dateText = meetingDate != null
        ? DateFormat('MMM d, yyyy').format(meetingDate)
        : ez.tr('DateNotSet');
    final timeText = meeting.meetingTime != null
        ? DateFormat('h:mm a').format(meeting.meetingTime!)
        : '';
    final scheduleText =
        timeText.isEmpty ? dateText : '$dateText • $timeText';

    final meetingTitle =
        (meeting.title?.isNotEmpty ?? false) ? meeting.title! : ez.tr('UntitledMeeting');

    return GestureDetector(
      onTap: () => Get.toNamed(RoutePaths.meeting, arguments: meeting),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Container(
          height: 120.h,
          decoration: BoxDecoration(
            color: AppColors.countainerColor,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        meetingTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        scheduleText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFF64616F),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if ((meeting.location?.isNotEmpty ?? false))
                        Text(
                          meeting.location!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: _statusBackgroundColor(meeting.status),
                    borderRadius: BorderRadius.circular(2000),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    ez.tr(meeting.status),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: _statusTextColor(meeting.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xffC0E3D7);
      case 'cancelled':
        return const Color(0xFFFFE0E0);
      case 'in_progress':
        return const Color(0xFFE3F2FD);
      default:
        return const Color(0xFFE8EAF6);
    }
  }

  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xff008D41);
      case 'cancelled':
        return const Color(0xFFD32F2F);
      case 'in_progress':
        return const Color(0xFF1976D2);
      default:
        return AppColors.primaryColor;
    }
  }
}
