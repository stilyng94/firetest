import 'package:firetest/services/auth_service.dart';
import 'package:firetest/services/config_service.dart';
import 'package:firetest/services/crashlytics_service.dart';
import 'package:firetest/services/fcm_service.dart';
import 'package:firetest/services/local_notification_service.dart';
import 'package:firetest/utils/fcm_handlers.dart';
import 'package:get/get.dart';

/// Initialize all GetServices
///
/// Services will remain in memory
Future<void> initServices(String assetName) async {
  await Get.putAsync<ConfigService>(() => ConfigService().init(assetName));
  await Get.putAsync<CrashlyticsService>(() => CrashlyticsService().init());
  Get.put<FCMService>(FCMService().init());
  await Get.putAsync<LocalNotificationService>(
      () => LocalNotificationService().init());
  await FCMMessagingHandlers.onMessageHandler();
  await FCMMessagingHandlers.onBackgroundHandler();
  await FCMMessagingHandlers.onMessageOpenedAppHandler();
  Get.lazyPut(() => AuthService());
  return;
}
