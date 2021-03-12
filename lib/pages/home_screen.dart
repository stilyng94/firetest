import 'dart:io';

import 'package:firetest/controllers/auth_controller.dart';
import 'package:firetest/core/adaptives/android_scaffold.dart';
import 'package:firetest/core/adaptives/cupertino_scaffold.dart';
import 'package:firetest/core/shared/size_config.dart';
import 'package:firetest/routes/router.dart';

import 'package:firetest/services/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fcmService = Get.find<FCMService>();
  final AuthController googleAuthController = Get.find<AuthController>();

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
            title: widget.title,
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN_ROUTE);
                      return;
                    },
                    child: Text("Login"),
                  ),
                  SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () {
                      return googleAuthController.signInOrUpWithGoogle();
                    },
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  Platform.isIOS
                      ? SignInWithAppleButton(onPressed: () {
                          return googleAuthController.signInOrUpWithApple();
                        })
                      : Container(
                          width: 0.0,
                          height: 0.0,
                        )
                ],
              ),
            ),
          )
        : AdaptiveAndroidScaffold(
            title: widget.title,
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.LOGIN_ROUTE);
                      return;
                    },
                    child: Text("Login"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.SIGNUP_ROUTE);
                      return;
                    },
                    child: Text("Signup"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      googleAuthController.signInOrUpWithGoogle();
                      return;
                    },
                    child: Text("signInOrUpWithGoogle"),
                  ),
                  SignInWithAppleButton(onPressed: () {
                    googleAuthController.signInOrUpWithApple();
                  })
                ],
              ),
            ),
          );
  }
}
