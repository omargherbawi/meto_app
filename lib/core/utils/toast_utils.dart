import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import '../errors/failures.dart';

class ToastUtils {
  // Show error snackbar from Failure object
  static void showFailure(Failure failure) {
    String errorMessage = _getErrorMessage(failure);
    _showSnackbar(
      message: errorMessage,
      backgroundColor: Colors.red.withValues(alpha: 0.9),
    );
  }

  // Show error snackbar from string
  static void showError(String error) {
    String errorMessage = _translateError(error);
    _showSnackbar(
      message: errorMessage,
      backgroundColor: Colors.red.withValues(alpha: 0.9),
    );
  }

  // Show error from Either result
  static void showErrorFromEither<E>(Either<E, dynamic> result) {
    result.fold(
      (failure) {
        if (failure is Failure) {
          showFailure(failure);
        } else {
          showError(failure.toString());
        }
      },
      (success) {
        // Do nothing on success
      },
    );
  }

  // Show success snackbar
  static void showSuccess(String message) {
    _showSnackbar(
      message: message.tr(),
      backgroundColor: Colors.green.withValues(alpha: 0.8),
    );
  }

  // Private helper methods
  static void _showSnackbar({
    required String message,
    required Color backgroundColor,
  }) {
    if (Get.isSnackbarOpen) {
      Future.delayed(Duration.zero, () => Get.closeAllSnackbars());
    }
    Get.rawSnackbar(
      message: message,
      backgroundColor: backgroundColor,
      snackPosition: GetPlatform.isDesktop
          ? SnackPosition.BOTTOM
          : SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      isDismissible: true,
    );
  }

  static String _getErrorMessage(Failure failure) {
    // Use the failure's message if available, otherwise use the failure type
    final message = failure.message ?? _getDefaultErrorMessage(failure);
    return _translateError(message);
  }

  static String _getDefaultErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'server_error';
      case NetworkFailure:
        return 'network_error';
      case CacheFailure:
        return 'cache_error';
      case AuthFailure:
        return 'auth_error';
      case ValidationFailure:
        return 'validation_error';
      case PermissionFailure:
        return 'permission_error';
      case TimeoutFailure:
        return 'timeout_error';
      case NotFoundFailure:
        return 'not_found';
      case UnauthorizedFailure:
        return 'unauthorized';
      case ForbiddenFailure:
        return 'forbidden';
      case ConflictFailure:
        return 'conflict_error';
      case RateLimitFailure:
        return 'rate_limit_error';
      case UnknownFailure:
      default:
        return 'unknown_error';
    }
  }

  static String _translateError(String error) {
    // Handle specific error mappings
    if (error == "auth.unauthorized") {
      return tr("Invalidcredentials,pleasecheckyourphoneNumberorpassword");
    } else if (error == "device_limit_reached_please_try_again") {
      return tr("account_exist");
    }
    
    // Try to translate the error, fallback to original if no translation found
    try {
      return error.tr();
    } catch (e) {
      return error;
    }
  }
}
