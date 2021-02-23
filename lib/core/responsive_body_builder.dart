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
    return ResponsiveSafeArea(
      builder: (context, size) => Container(
        width: size.width,
        child: child,
        height: size.height,
      ),
    );
  }
}

class ResponsiveSafeArea extends StatelessWidget {
  const ResponsiveSafeArea({
    Key key,
    @required ResponsiveSafeAreaBuilder builder,
  })  : responsiveSafeAreaBuilder = builder,
        super(key: key);
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
