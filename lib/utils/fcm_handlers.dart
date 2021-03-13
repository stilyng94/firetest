import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firetest/services/db_service.dart';
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

      return Future<void>.value();
    });
    return Future<void>.value();
  }

  static Future<void> onMessageOpenedAppHandler() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Got a message opened!');
    });
    return Future<void>.value();
  }

  static Future<void> onMessageStartTerminatedApp() async {
    final fcmService = Get.find<FCMService>();
    RemoteMessage initialMessage =
        await fcmService.firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {}
    return Future<void>.value();
  }

  static persistNotice(Map<String, dynamic> jsonData) async {
    //!Increase total notification count. That is those attended to

    return Future<void>.value();
  }
}

//!Background
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //! Initialize database for background
  await Get.putAsync<DBService>(() => DBService().initDBService());
  await FCMMessagingHandlers.persistNotice(message.data);

  print("Handling a background message: ${message.messageId}");
  return Future<void>.value();
}
