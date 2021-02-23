import 'dart:io';
import 'package:firetest/core/adaptives/android_scaffold.dart';
import 'package:firetest/core/adaptives/cupertino_scaffold.dart';
import 'package:firetest/screens/signup/signup_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);
  final title = "Signup";
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? AdaptiveCupertinoScaffold(title: title, child: SignupWidget())
        : AdaptiveAndroidScaffold(title: title, child: SignupWidget());
  }
}
