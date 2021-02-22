import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firetest/core/my_app_flavors/android_app.dart';
import 'package:firetest/core/my_app_flavors/ios_app.dart';
import 'package:firetest/services/config_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final configService = Get.find<ConfigService>();
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? MyIOSApp(
            analytics: analytics,
            configService: configService,
          )
        : MyAndroidApp(
            analytics: analytics,
            configService: configService,
          );
  }
}
