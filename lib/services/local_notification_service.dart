import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService extends GetxService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<LocalNotificationService> init() async {
    this.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    this._setup();
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    return this;
  }

  void _setup() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    this.flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (_) async {
      print(_);
    });
    return;
  }
}
