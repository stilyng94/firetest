import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firetest/local_data_sources/general_data_source.dart';
import 'package:firetest/repositories/general_repository.dart';
import 'package:firetest/services/auth_service.dart';
import 'package:firetest/services/config_service.dart';
import 'package:firetest/services/crashlytics_service.dart';
import 'package:firetest/services/db_service.dart';
import 'package:firetest/services/fcm_service.dart';
import 'package:firetest/services/general_service.dart';
import 'package:firetest/services/local_notification_service.dart';
import 'package:firetest/utils/fcm_handlers.dart';
import 'package:get/get.dart';

/// Initialize all GetServices
///
/// Services will remain in memory
Future<void> initServices(String assetName) async {
  await Get.putAsync<ConfigService>(() => ConfigService().init(assetName));
  await Get.putAsync<DBService>(() => DBService().initDBService());
  await Get.putAsync<CrashlyticsService>(() => CrashlyticsService().init());
  await Get.putAsync<GeneralService>(() => GeneralService(
          GeneralRepo(GeneralLocalDataSource(Get.find<DBService>().dbStorage)))
      .init());

  Get.put<AuthService>(AuthService().init());
  Get.put<FCMService>(FCMService().init());
  await Get.putAsync<LocalNotificationService>(
      () => LocalNotificationService().init());
  await FCMMessagingHandlers.onMessageHandler();
  await FCMMessagingHandlers.onMessageOpenedAppHandler();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  return;
}
