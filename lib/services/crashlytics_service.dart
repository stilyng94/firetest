import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firetest/services/config_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CrashlyticsService extends GetxService {
  Future<CrashlyticsService> init() async {
    final configService = Get.find<ConfigService>();
    if (configService.configModel.enableCrashlytics) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
        );
      }).sendPort);
    }
    return this;
  }
}
