import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class ToastUtils {
  // Show error snackbar
  static void showError(String error) {
    if (error == "auth.unauthorized") {
      error = tr("Invalidcredentials,pleasecheckyourphoneNumberorpassword");
    } else if (error == "device_limit_reached_please_try_again") {
      error = tr("account_exist");
    }

    // Ensure that the controller is initialized before calling `closeAllSnackbars`
    if (Get.isSnackbarOpen) {
      // You can delay this action to allow the snackbar controller to be ready.
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: error.tr(),
      backgroundColor: Colors.red.withValues(alpha: 0.9),
      snackPosition: GetPlatform.isDesktop
          ? SnackPosition.BOTTOM
          : SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  // Show success snackbar
  static void showSuccess(String message) {
    if (Get.isSnackbarOpen) {
      // Same as above, make sure to close snackbars with a delay to ensure initialization
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: message.tr(),
      backgroundColor: Colors.green.withValues(alpha: 0.8),
      snackPosition: GetPlatform.isDesktop
          ? SnackPosition.BOTTOM
          : SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }
}
