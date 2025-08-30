import 'package:easy_localization/easy_localization.dart';

class MeetingValidation {
  // Validation methods
  static String? validateMeetingName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'MeetingNameRequired'.tr();
    }
    if (value.trim().length < 3) {
      return 'MeetingNameMinLength'.tr();
    }
    if (value.trim().length > 50) {
      return 'MeetingNameMaxLength'.tr();
    }
    return null;
  }

  static String? validateDate(String? value, DateTime? selectedDate) {
    if (value == null || value.trim().isEmpty) {
      return 'DateRequired'.tr();
    }
    if (selectedDate == null) {
      return 'DateSelectValid'.tr();
    }
    // Check if selected date is not in the past
    if (selectedDate.isBefore(
      DateTime.now().subtract(const Duration(days: 1)),
    )) {
      return 'DateNotPast'.tr();
    }
    return null;
  }

  static String? validateTime(String? value, DateTime? selectedTime) {
    if (value == null || value.trim().isEmpty) {
      return 'TimeRequired'.tr();
    }
    if (selectedTime == null) {
      return 'TimeSelectValid'.tr();
    }
    return null;
  }

  static String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'LocationRequired'.tr();
    }
    if (value.trim().length < 3) {
      return 'LocationMinLength'.tr();
    }
    if (value.trim().length > 100) {
      return 'LocationMaxLength'.tr();
    }
    return null;
  }

  // Check if all fields are valid
  static bool isFormValid({
    required String meetingName,
    required String date,
    required String time,
    required String location,
    required DateTime? selectedDate,
    required DateTime? selectedTime,
  }) {
    return validateMeetingName(meetingName) == null &&
        validateDate(date, selectedDate) == null &&
        validateTime(time, selectedTime) == null &&
        validateLocation(location) == null;
  }
}
