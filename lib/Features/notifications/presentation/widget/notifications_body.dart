import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/assets_paths.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => NotificationItem(),
      itemCount: 10,
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 23.r,
              backgroundImage: AssetImage(AssetsPaths.userAvatar),
            ),
            title: Text(
              'انت مدعو الى حضور اجتماع',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الاحد - 15:00 - 16:00',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff64616F)),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'عمان - الاردن',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xff64616F)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
