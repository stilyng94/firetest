import 'dart:io';

import 'package:firetest/core/adaptives/android_scaffold.dart';
import 'package:firetest/core/adaptives/cupertino_scaffold.dart';
import 'package:firetest/screens/login/login_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  final title = "Login";

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? AdaptiveCupertinoScaffold(title: title, child: LoginWidget())
        : AdaptiveAndroidScaffold(title: title, child: LoginWidget());
  }
}
