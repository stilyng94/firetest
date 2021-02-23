import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// Adaptive Android Scaffold
class AdaptiveAndroidScaffold extends StatelessWidget {
  final Widget child;
  final String title;

  const AdaptiveAndroidScaffold({Key key, @required this.child, this.title})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: this.child,
    );
  }
}
