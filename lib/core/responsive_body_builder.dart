import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class BuildResponsiveChild extends StatelessWidget {
  const BuildResponsiveChild({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveSafeArea(
      responsiveSafeAreaBuilder: (context, size) => Container(
        width: size.width,
        child: child,
        height: size.height,
      ),
    );
  }
}

class _ResponsiveSafeArea extends StatelessWidget {
  const _ResponsiveSafeArea({
    Key key,
    this.responsiveSafeAreaBuilder,
  }) : super(key: key);
  final ResponsiveSafeAreaBuilder responsiveSafeAreaBuilder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return responsiveSafeAreaBuilder(context, constraints.biggest);
        },
      ),
    );
  }
}

typedef Widget ResponsiveSafeAreaBuilder(BuildContext context, Size size);
