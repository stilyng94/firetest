import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Adaptive Android Scaffold
class AdaptiveAndroidScaffold extends StatelessWidget {
  final Widget child;

  const AdaptiveAndroidScaffold({Key key, @required this.child})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Android"),
      ),
      body: this.child,
    );
  }
}
