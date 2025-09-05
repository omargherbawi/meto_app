import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_body.dart';
import 'package:meto_application/core/widget/custom_app_bar.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Meeting 1",
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: Colors.white, size: 27.sp),
          ),
        ],
      ),
      body: MeetingBody(),
    );
  }
}
