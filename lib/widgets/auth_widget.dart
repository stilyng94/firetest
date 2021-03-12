import 'dart:io';
import 'package:firetest/controllers/auth_controller.dart';
import 'package:firetest/core/responsive_body_builder.dart';
import 'package:firetest/core/shared/size_config.dart';
import 'package:firetest/routes/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class AuthWidget extends StatefulWidget {
  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  TapGestureRecognizer tapGestureRecognizer;
  TapGestureRecognizer privacyTapGestureRecognizer;
  TapGestureRecognizer termsTapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    tapGestureRecognizer = TapGestureRecognizer()..onTap = handlePress;
    privacyTapGestureRecognizer = TapGestureRecognizer()..onTap = onPrivacy;
    termsTapGestureRecognizer = TapGestureRecognizer()..onTap = onTerms;
  }

  void handlePress() {
    Get.toNamed(Routes.LOGIN_ROUTE);
    return;
  }

  void onPrivacy() {
    return;
  }

  void onTerms() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BuildResponsiveChild(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            height: 150.0,
            color: Colors.yellow,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10.0),
          ),
          Positioned(
              height: 300.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthWidgetBody1(
                        termsTapGestureRecognizer: termsTapGestureRecognizer,
                        privacyTapGestureRecognizer:
                            privacyTapGestureRecognizer),
                    //!Buttons
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),

                    AuthWidgetSocial(),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),

                    Text.rich(
                      TextSpan(text: "Already have an account?  ", children: [
                        TextSpan(
                            text: "Login",
                            recognizer: tapGestureRecognizer,
                            style: TextStyle(color: Colors.amber))
                      ]),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  @override
  void dispose() {
    tapGestureRecognizer?.dispose();
    privacyTapGestureRecognizer?.dispose();
    termsTapGestureRecognizer?.dispose();
    super.dispose();
  }
}

class AuthWidgetSocial extends StatelessWidget {
  AuthWidgetSocial({
    Key key,
  }) : super(key: key);

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignInButton(
          Buttons.GoogleDark,
          onPressed: () async {
            await authController.signInOrUpWithGoogle();
            return;
          },
          text: "Connect With Google",
        ),
        SizedBox(
          height: getProportionateScreenHeight(10.0),
        ),
        Platform.isIOS
            ? SignInButton(
                Buttons.AppleDark,
                onPressed: () async {
                  await authController.signInOrUpWithApple();
                  return;
                },
                text: "Connect With Apple",
              )
            : Container(
                width: 0.0,
                height: 0.0,
              ),
        Platform.isIOS
            ? SizedBox(
                height: getProportionateScreenHeight(10.0),
              )
            : Container(
                width: 0.0,
                height: 0.0,
              ),
        SignInButton(
          Buttons.Email,
          onPressed: () {
            Get.toNamed(Routes.SIGNUP_ROUTE);
            return;
          },
          text: "Sign Up Using Email",
        ),
      ],
    );
  }
}

class AuthWidgetBody1 extends StatelessWidget {
  const AuthWidgetBody1({
    Key key,
    @required this.termsTapGestureRecognizer,
    @required this.privacyTapGestureRecognizer,
  }) : super(key: key);

  final TapGestureRecognizer termsTapGestureRecognizer;
  final TapGestureRecognizer privacyTapGestureRecognizer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ObxValue<RxBool>(
            (data) => Checkbox(
                  value: data.value,
                  onChanged: (_) {
                    data.toggle();
                  },
                ),
            false.obs),
        SizedBox(
          width: getProportionateScreenWidth(10.0),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(text: "I've reviewed and agreed to the", children: [
              TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: "Terms of Services",
                  recognizer: termsTapGestureRecognizer,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  )),
              TextSpan(
                text: " ",
              ),
              TextSpan(
                text: "and",
              ),
              TextSpan(
                text: " ",
              ),
              TextSpan(
                  text: "Privacy Policy",
                  recognizer: privacyTapGestureRecognizer,
                  style: TextStyle(decoration: TextDecoration.underline)),
              TextSpan(
                text: " ",
              ),
              TextSpan(
                text: "Regarding the consent for the use of my personal data.",
              )
            ]),
            maxLines: 5,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
