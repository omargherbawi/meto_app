import 'package:hive/hive.dart';
import 'package:meto_application/config/hive_box_constants.dart';

class HiveServices {
  final Box _box = Hive.box("App");

  Box getInstance() {
    return _box;
  }

  void setIsOnBoardingShown(bool isShown) {
    _box.put(AppSettingsBoxConstants.isOnBoardingShown, isShown);
  }

  bool getIsOnBoardingShown() {
    return (_box.get(AppSettingsBoxConstants.isOnBoardingShown) as bool?) ??
        false;
  }

  void setAllowNotificationToApp(bool enabled) {
    _box.put(AppSettingsBoxConstants.allowNotificationToApp, enabled);
  }

  bool getAllowNotificationToApp() {
    return (_box.get(AppSettingsBoxConstants.allowNotificationToApp)
            as bool?) ??
        true;
  }

  Future<void> clearPreferences() async {
    bool onBoardingStatus = getIsOnBoardingShown();
    bool notificationStatus = getAllowNotificationToApp();
    _box.clear();

    if (onBoardingStatus) {
      setIsOnBoardingShown(onBoardingStatus);
    }

    setAllowNotificationToApp(notificationStatus);
  }

  // Method to reset onboarding status for testing
  void resetOnboardingStatus() {
    _box.delete(AppSettingsBoxConstants.isOnBoardingShown);
  }
}
