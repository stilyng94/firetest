import 'dart:io';

import 'package:firetest/core/constants/asset_paths.dart';
import 'package:firetest/core/responsive_body_builder.dart';
import 'package:firetest/routes/router.dart';
import 'package:firetest/services/auth_service.dart';
import 'package:firetest/widgets/splash_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    afterSplash();
  }

  void afterSplash() {
    Future.delayed(Duration(seconds: 2), () {
      if (Get.find<AuthService>().user == null) {
        return Get.offAllNamed(Routes.ONBOARD_ROUTE);
      }
      return Get.offAllNamed(Routes.HOME_ROUTE);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: BuildResponsiveChild(
                child: buildSplashBody(AssetPaths.SPLASH_SVG)))
        : Scaffold(
            body: BuildResponsiveChild(
                child: buildSplashBody(AssetPaths.SPLASH_SVG)),
          );
  }
}
