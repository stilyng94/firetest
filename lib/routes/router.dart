import 'package:firetest/bindings/login_binding.dart';
import 'package:firetest/bindings/signup_binding.dart';
import 'package:firetest/screens/home/home_screen.dart';
import 'package:firetest/screens/login/login_page.dart';
import 'package:firetest/screens/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NamedRoutes {
  static const home = "/";
  static const login = "/login";
  static const signup = "/signup";
}

abstract class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case NamedRoutes.home:
        return GetPageRoute(
            page: () => MyHomePage(
                  title: "Home is Home",
                ),
            bindings: [LoginBinding()]);
      case NamedRoutes.login:
        return GetPageRoute(
            page: () => LoginPage(), bindings: [LoginBinding()]);
      case NamedRoutes.signup:
        return GetPageRoute(
            page: () => SignupPage(), bindings: [SignupBinding()]);
      default:
        return null;
    }
  }
}
