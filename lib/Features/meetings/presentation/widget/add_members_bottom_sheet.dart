import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_header_widget.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_send_invite_widget.dart';

class AddMembersBottomSheet extends StatefulWidget {
  const AddMembersBottomSheet({super.key});

  @override
  State<AddMembersBottomSheet> createState() =>
      _CreateMeetingBottomSheetState();
}

class _CreateMeetingBottomSheetState extends State<AddMembersBottomSheet> {
  bool isLinkSelected = true;
  final List<String> friends = ['Mohammed', 'Sami', 'Ahmed', 'Fatima', 'Layla'];
  final Set<String> selectedFriends = {};

  String inviteLink = 'https://meto.app/invite/XYZ123';

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: inviteLink));
  }

  void onFriendSelectionChanged(String friend, bool? value) {
    setState(() {
      if (value == true) {
        selectedFriends.add(friend);
      } else {
        selectedFriends.remove(friend);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.97,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
      ),
      child: Column(
        children: [
          MeetingHeaderWidget(
            title: 'Invite',
            onCancel: () => Get.back(),
            onSave: () => Get.back(),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MeetingSendInviteWidget(
                    isLinkSelected: isLinkSelected,
                    onLinkSelected: () => setState(() => isLinkSelected = true),
                    onFriendsSelected: () =>
                        setState(() => isLinkSelected = false),
                    onCopyLink: copyToClipboard,
                    inviteLink: inviteLink,
                    friends: friends,
                    selectedFriends: selectedFriends,
                    onFriendSelectionChanged: onFriendSelectionChanged,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
