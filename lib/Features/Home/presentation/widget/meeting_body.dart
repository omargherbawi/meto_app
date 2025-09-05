import 'package:flutter/material.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_header.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_chat.dart';

class MeetingBody extends StatelessWidget {
  const MeetingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MeetingHeader(),
        Expanded(
          child: MeetingChat(),
        ),
      ],
    );
  }
}
