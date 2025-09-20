
import 'package:easy_localization/easy_localization.dart';

class TextFieldValidation {
  /// Validates email format
  /// Returns error message if invalid, null if valid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'emailRequired'.tr();
    }
    
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'emailInvalid'.tr();
    }
    
    return null;
  }

  /// Validates password length (minimum 8 characters)
  /// Returns error message if invalid, null if valid
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'passwordRequired'.tr();
    }
    
    if (value.length < 8) {
      return 'passwordMinLength'.tr();
    }
    
    return null;
  }

  /// Validates name field (not empty, minimum 2 characters)
  /// Returns error message if invalid, null if valid
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'nameRequired'.tr();
    }
    
    if (value.trim().length < 2) {
      return 'nameMinLength'.tr();
    }
    
    return null;
  }

  /// Validates confirm password (matches original password)
  /// Returns error message if invalid, null if valid
  static String? validateConfirmPassword(String? value, String? originalPassword) {
    if (value == null || value.isEmpty) {
      return 'confirmPasswordRequired'.tr();
    }
    
    if (value != originalPassword) {
      return 'passwordsDoNotMatch'.tr();
    }
    
    return null;
  }

  /// Validates phone number (basic format check)
  /// Returns error message if invalid, null if valid
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'phoneRequired'.tr();
    }
    
    // Remove spaces, dashes, and parentheses
    final cleanedPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (!RegExp(r'^\d{10,15}$').hasMatch(cleanedPhone)) {
      return 'phoneInvalid'.tr();
    }
    
    return null;
  }

  /// Generic required field validator
  /// Returns error message if empty, null if valid
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName ${'fieldRequired'.tr()}';
    }
    
    return null;
  }

  /// Validates minimum length
  /// Returns error message if too short, null if valid
  static String? validateMinLength(String? value, int minLength, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName ${'fieldRequired'.tr()}';
    }
    
    if (value.length < minLength) {
      return '$fieldName ${'fieldMinLength'.tr()} $minLength';
    }
    
    return null;
  }
}
