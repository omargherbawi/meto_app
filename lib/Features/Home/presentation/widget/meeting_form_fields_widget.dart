import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meto_application/core/widget/custom_text_form_field.dart';
import 'package:meto_application/core/validation/meeting_validation.dart';

class MeetingFormFieldsWidget extends StatelessWidget {
  final TextEditingController meetingNameController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final TextEditingController locationController;
  final DateTime? selectedDate;
  final DateTime? selectedTime;
  final bool showValidationErrors;
  final VoidCallback onDateTap;
  final VoidCallback onTimeTap;
  final Function(String)? onFieldChanged;

  const MeetingFormFieldsWidget({
    super.key,
    required this.meetingNameController,
    required this.dateController,
    required this.timeController,
    required this.locationController,
    required this.selectedDate,
    required this.selectedTime,
    required this.showValidationErrors,
    required this.onDateTap,
    required this.onTimeTap,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Meeting Name Field
        _buildFormField(
          controller: meetingNameController,
          hintText: "MeetingName".tr(),
          suffixIcon: Icon(Icons.edit_outlined, color: Colors.grey),
          isError: showValidationErrors && 
              MeetingValidation.validateMeetingName(meetingNameController.text) != null,
          errorText: showValidationErrors ? 
              MeetingValidation.validateMeetingName(meetingNameController.text) : null,
          onChanged: onFieldChanged,
        ),

        // Date Field
        _buildFormField(
          controller: dateController,
          hintText: "Date".tr(),
          suffixIcon: Icon(Icons.date_range, color: Colors.grey),
          isError: showValidationErrors && 
              MeetingValidation.validateDate(dateController.text, selectedDate) != null,
          errorText: showValidationErrors ? 
              MeetingValidation.validateDate(dateController.text, selectedDate) : null,
          onTap: onDateTap,
          onChanged: onFieldChanged,
        ),

        // Time Field
        _buildFormField(
          controller: timeController,
          hintText: "Time".tr(),
          suffixIcon: Icon(Icons.schedule, color: Colors.grey),
          isError: showValidationErrors && 
              MeetingValidation.validateTime(timeController.text, selectedTime) != null,
          errorText: showValidationErrors ? 
              MeetingValidation.validateTime(timeController.text, selectedTime) : null,
          onTap: onTimeTap,
          onChanged: onFieldChanged,
        ),

        // Location Field
        _buildFormField(
          controller: locationController,
          hintText: "SelectLocation".tr(),
          suffixIcon: Icon(Icons.location_on_outlined, color: Colors.grey),
          isError: showValidationErrors && 
              MeetingValidation.validateLocation(locationController.text) != null,
          errorText: showValidationErrors ? 
              MeetingValidation.validateLocation(locationController.text) : null,
          onChanged: onFieldChanged,
        ),
      ],
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hintText,
    required Widget suffixIcon,
    required bool isError,
    String? errorText,
    VoidCallback? onTap,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormField(
            controller: controller,
            hintText: hintText,
            isError: isError,
            onTap: onTap,
            onChanged: onChanged,
            suffixIcon: suffixIcon,
          ),
          if (errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h, left: 12.w),
              child: Text(
                errorText,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
