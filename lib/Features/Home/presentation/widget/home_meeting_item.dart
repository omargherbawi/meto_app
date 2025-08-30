import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/config/app_colors.dart';

class HomeMeetingsItem extends StatelessWidget {
  const HomeMeetingsItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: SizedBox(
        height: 120.h,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.countainerColor,
            borderRadius: BorderRadius.circular(18.r),
          ),

          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اجتماع 1",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "اليوم - 7:00 PM",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xFF64616F),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'مكتمل',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xff008D41),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffC0E3D7),
                    borderRadius: BorderRadius.circular(2000),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
