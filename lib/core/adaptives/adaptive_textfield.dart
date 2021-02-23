import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final BoxDecoration boxDecoration;
  final InputDecoration inputDecoration;
  final TextInputType textInputType;
  final bool obscureText;

  const AdaptiveTextField(
      {Key key,
      @required this.textEditingController,
      this.boxDecoration = const BoxDecoration(),
      this.inputDecoration = const InputDecoration(),
      this.textInputType = TextInputType.text,
      this.obscureText = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: this.textEditingController,
            decoration: this.boxDecoration,
            keyboardType: this.textInputType,
            obscureText: this.obscureText,
          )
        : TextField(
            controller: this.textEditingController,
            decoration: this.inputDecoration,
            obscureText: this.obscureText,
            keyboardType: this.textInputType,
          );
  }
}
