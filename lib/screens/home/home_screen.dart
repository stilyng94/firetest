import 'dart:io';

import 'package:firetest/core/adaptive_scaffold/android_scaffold.dart';
import 'package:firetest/core/adaptive_scaffold/cupertino_scaffold.dart';
import 'package:firetest/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fcmService = Get.find<FCMService>();

  @override
  void initState() {
    super.initState();
    fcmService.getFcmToken();
    fcmService.seekPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? AdaptiveCupertinoScaffold(
            child: Center(),
          )
        : AdaptiveAndroidScaffold(
            child: Center(),
          );
  }
}
