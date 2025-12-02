import Flutter
import GoogleMaps
import UIKit
import awesome_notifications
import awesome_notifications_fcm

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB4xPR059UjbHgmzD6zw56G40FbeoF0zLI")
    
    // Initialize Awesome Notifications for background handling
    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
      SwiftAwesomeNotificationsPlugin.register(
        with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
      SwiftAwesomeNotificationsFcmPlugin.register(
        with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotificationsfcm.AwesomeNotificationsFcmPlugin")!)
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
