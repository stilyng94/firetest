import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firetest/core/constants/environment.dart';
import 'package:firetest/routes/router.dart';
import 'package:firetest/screens/home/home_screen.dart';
import 'package:firetest/services/auth_service.dart';
import 'package:firetest/services/config_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class MyAndroidApp extends StatelessWidget {
  final ConfigService configService;
  final FirebaseAnalytics analytics;
  final AuthService authService;
  const MyAndroidApp(
      {Key key,
      @required this.configService,
      @required this.analytics,
      @required this.authService})
      : assert(configService != null, authService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: configService.configModel.environment == Environment.dev,
      defaultTransition: Transition.native,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Get.key,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorObservers: [
        GetObserver(),
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
    );
  }
}
