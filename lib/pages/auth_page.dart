import 'dart:io';
import 'package:firetest/widgets/auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(child: AuthWidget())
        : Scaffold(body: AuthWidget());
  }
}
