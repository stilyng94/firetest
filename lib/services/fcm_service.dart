import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FCMService extends GetxService {
  FirebaseMessaging firebaseMessaging;
  FCMService init() {
    this.firebaseMessaging = FirebaseMessaging.instance;
    return this;
  }

  Future<void> seekPermission() async {
    if (!Platform.isAndroid) {
      await this.firebaseMessaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
    }
    await this.firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, // Required to display a heads up notification
          badge: true,
          sound: true,
        );
    return;
  }

  Future<String> getFcmToken() async {
    String fcmToken;
    if (Platform.isIOS || Platform.isMacOS) {
      fcmToken = await this.firebaseMessaging.getAPNSToken();
    } else {
      fcmToken = await this.firebaseMessaging.getToken();
    }
    this.firebaseMessaging.onTokenRefresh.listen(print);
    print("Fcm Token is ==>>  $fcmToken");
    return fcmToken;
  }
}
//TODO:Save fcm token
