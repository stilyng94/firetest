import 'package:firetest/core/constants/asset_paths.dart';
import 'package:firetest/core/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSplashBody(String assetPath) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Container(
      height: getProportionateScreenWidth(200.0),
      width: getProportionateScreenWidth(200.0),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AssetPaths.SPLASH_SVG,
        semanticsLabel: assetPath,
        fit: BoxFit.contain,
      ),
    ),
  ]);
}
