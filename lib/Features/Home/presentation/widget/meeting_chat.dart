import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/Features/Home/presentation/widget/message_item.dart';
import 'package:meto_application/config/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class MeetingChat extends StatelessWidget {
  const MeetingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return MessageItem();
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20, right: 8, left: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Message...'.tr(),
                    hintStyle: TextStyle(color: Color(0xffA4A5A7)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5.w),
              IconButton(
                onPressed: () {},
                icon: Transform.rotate(
                  angle: context.locale.languageCode == 'ar' ? -6 : -0.5,
                  child: Icon(Icons.send),
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
