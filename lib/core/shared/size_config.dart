import 'package:flutter/material.dart';
import 'package:get/get.dart';

//!Get the proportionate height as per screen size
double getProportionateScreenHeight(
  double inputHeight,
) {
  double screenHeight = Get.height;
  if (Get.mediaQuery.orientation == Orientation.landscape) {
    screenHeight = Get.width;
  }

  return (inputHeight / 812.0) * screenHeight;
}

//!Get the proportionate width as per screen size
double getProportionateScreenWidth(
  double inputWidth,
) {
  double screenWidth = Get.width;
  if (Get.mediaQuery.orientation == Orientation.landscape) {
    screenWidth = Get.height;
  }
  return (inputWidth / 375.0) * screenWidth;
}
