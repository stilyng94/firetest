import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firetest/core/constants/environment.dart';
import 'package:firetest/routes/router.dart';
import 'package:firetest/screens/home/home_screen.dart';
import 'package:firetest/services/auth_service.dart';
import 'package:firetest/services/config_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class MyIOSApp extends StatelessWidget {
  final ConfigService configService;
  final FirebaseAnalytics analytics;
  final AuthService authService;

  const MyIOSApp(
      {Key key,
      @required this.configService,
      @required this.analytics,
      @required this.authService})
      : assert(
          configService != null,
          analytics != null,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetCupertinoApp(
      enableLog: configService.configModel.environment == Environment.dev,
      defaultTransition: Transition.native,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      navigatorKey: Get.key,
      theme: CupertinoThemeData(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      navigatorObservers: [
        GetObserver(),
        FirebaseAnalyticsObserver(analytics: analytics)
      ],
    );
  }
}
