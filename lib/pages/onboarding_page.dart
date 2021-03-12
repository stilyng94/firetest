import 'dart:io';

import 'package:firetest/widgets/onboarding_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(child: OnBoardingWidget())
        : Scaffold(
            body: OnBoardingWidget(),
          );
  }
}
