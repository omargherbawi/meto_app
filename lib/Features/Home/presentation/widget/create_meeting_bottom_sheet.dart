import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meto_application/Features/Home/domain/entities/meeting.dart';
import 'package:meto_application/Features/Home/presentation/controller/home_controller.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_form_fields_widget.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_header_widget.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_picker_utils.dart';
import 'package:meto_application/Features/Home/presentation/widget/meeting_send_invite_widget.dart';
import 'package:meto_application/Features/auth/presentation/controller/auth_controller.dart';
import 'package:meto_application/core/routes/route_paths.dart';
import 'package:meto_application/core/utils/toast_utils.dart';
import 'package:meto_application/core/validation/meeting_validation.dart';
import 'package:uuid/uuid.dart';

class CreateMeetingBottomSheet extends StatefulWidget {
  const CreateMeetingBottomSheet({super.key});

  @override
  State<CreateMeetingBottomSheet> createState() =>
      _CreateMeetingBottomSheetState();
}

class _CreateMeetingBottomSheetState extends State<CreateMeetingBottomSheet> {
  bool isLinkSelected = true;
  bool showValidationErrors = false;
  final List<String> friends = ['Mohammed', 'Sami', 'Ahmed', 'Fatima', 'Layla'];
  final Set<String> selectedFriends = {};

  final TextEditingController meetingNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  DateTime? selectedDate;
  DateTime? selectedTime;
  double? selectedLatitude;
  double? selectedLongitude;

  late final HomeController homeController;
  late final AuthController authController;
  final Uuid _uuid = const Uuid();

  late String meetingId;
  String inviteLink = '';

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
    authController = Get.find<AuthController>();
    meetingId = _generateMeetingId();
    inviteLink = _generateInviteLink(meetingId);
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: inviteLink));
  }

  void saveMeeting() {
    if (homeController.isCreatingMeeting.value) return;

    setState(() {
      showValidationErrors = true;
    });

    if (!MeetingValidation.isFormValid(
      meetingName: meetingNameController.text,
      date: dateController.text,
      time: timeController.text,
      location: locationController.text,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    )) {
      ToastUtils.showError('PleaseFillAllFields');
      return;
    }

    final ownerId = authController.profile.value?.id;
    if (ownerId == null) {
      ToastUtils.showError('PleaseLoginFirst');
      return;
    }

    final currentMeetingId = _generateMeetingId();
    final combinedInviteLink = _generateInviteLink(currentMeetingId);
    final meetingDate = selectedDate!;
    final meetingDateTime = DateTime(
      meetingDate.year,
      meetingDate.month,
      meetingDate.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final meeting = Meeting(
      id: currentMeetingId,
      ownerId: ownerId,
      title: meetingNameController.text.trim(),
      location: locationController.text.trim(),
      latitude: selectedLatitude,
      longitude: selectedLongitude,
      meetingTime: meetingDateTime,
      inviteLink: combinedInviteLink,
      status: 'scheduled',
      date: meetingDate,
    );

    setState(() {
      inviteLink = combinedInviteLink;
      meetingId = currentMeetingId;
    });

    _createMeeting(meeting);
  }

  Future<void> _createMeeting(Meeting meeting) async {
    final success = await homeController.createMeeting(meeting);
    if (success) {
      ToastUtils.showSuccess('MeetingCreated');
      Get.back();
    }
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = date;
      dateController.text = MeetingPickerUtils.formatDate(date);
      if (showValidationErrors) {
        setState(() {});
      }
    });
  }

  void onTimeSelected(DateTime time) {
    setState(() {
      selectedTime = time;
      timeController.text = MeetingPickerUtils.formatTime(time);
      if (showValidationErrors) {
        setState(() {});
      }
    });
  }

  void onFieldChanged(String value) {
    if (showValidationErrors) {
      setState(() {});
    }
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

  void onLocationTap() async {
    try {
      final result = await Get.toNamed(RoutePaths.map);
      if (result != null) {
        setState(() {
          locationController.text = result['address'] ?? '';
          selectedLatitude = (result['lat'] as num?)?.toDouble();
          selectedLongitude = (result['lng'] as num?)?.toDouble();
        });
        if (showValidationErrors) {
          setState(() {});
        }
      }
    } catch (e) {
      ToastUtils.showError('FailedToSelectLocation');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.93,
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
            title: 'CreateMeeting',
            onSave: saveMeeting,
            onCancel: () => Get.back(),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MeetingFormFieldsWidget(
                    meetingNameController: meetingNameController,
                    dateController: dateController,
                    timeController: timeController,
                    locationController: locationController,
                    selectedDate: selectedDate,
                    selectedTime: selectedTime,
                    showValidationErrors: showValidationErrors,
                    onDateTap: () => MeetingPickerUtils.showIOSDatePicker(
                      context: context,
                      selectedDate: selectedDate,
                      onDateSelected: onDateSelected,
                    ),
                    onTimeTap: () => MeetingPickerUtils.showIOSTimePicker(
                      context: context,
                      selectedTime: selectedTime,
                      onTimeSelected: onTimeSelected,
                    ),
                    onLocationTap: onLocationTap,
                    onFieldChanged: onFieldChanged,
                  ),

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

  @override
  void dispose() {
    meetingNameController.dispose();
    dateController.dispose();
    timeController.dispose();
    locationController.dispose();
    super.dispose();
  }

  String _generateMeetingId() {
    return _uuid.v4();
  }

  String _generateInviteLink(String meetingId) {
    return 'https://meto.app/invite/$meetingId';
  }
}
