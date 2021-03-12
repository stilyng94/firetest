import 'dart:io';

import 'package:firetest/widgets/login_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);
  final title = "Login";

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(child: LoginWidget())
        : Scaffold(body: LoginWidget());
  }
}
