import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firetest/services/fcm_service.dart';
import 'package:firetest/services/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

abstract class FCMMessagingHandlers {
  static Future<void> onMessageHandler() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      //! If `onMessage` is triggered with a notification, construct our own
      //! local notification to show to users using the created channel.

      if (notification != null && android != null) {
        final flutterLocalNotificationsPlugin =
            Get.find<LocalNotificationService>();
        flutterLocalNotificationsPlugin.flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                "high_importance_channel",
                "High Importance Notifications",
                "This channel is used for important notifications.",
                // other properties...
              ),
            ));
      }

      return;
    });
  }

  static Future<void> onMessageOpenedAppHandler() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message opened!');
      return;
    });
  }

  static Future<void> onBackgroundHandler() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return;
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print("Handling a background message: ${message.messageId}");
    return;
  }

  static Future<void> onMessageStartTerminatedApp() async {
    final fcmService = Get.find<FCMService>();
    RemoteMessage initialMessage =
        await fcmService.firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {}
  }
}
//TODO: Save notifications
