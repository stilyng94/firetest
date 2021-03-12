import 'package:firetest/bindings/auth_page_binding.dart';
import 'package:firetest/bindings/login_binding.dart';
import 'package:firetest/bindings/signup_binding.dart';
import 'package:firetest/middlewares/auth_middleware.dart';
import 'package:firetest/pages/auth_page.dart';
import 'package:firetest/pages/home_screen.dart';
import 'package:firetest/pages/login_screen.dart';
import 'package:firetest/pages/onboarding_page.dart';
import 'package:firetest/pages/signup_screen.dart';
import 'package:firetest/pages/splash_page.dart';

import 'package:get/get.dart';

abstract class Routes {
  static const SPLASH_ROUTE = "/";

  static const HOME_ROUTE = "/home";
  static const LOGIN_ROUTE = "/login";
  static const SIGNUP_ROUTE = "/signup";
  static const ONBOARD_ROUTE = "/onboard";
  static const AUTH_ROUTE = "/auth";
}

abstract class AppPages {
  static final List<GetPage> appPages = [
    GetPage(name: Routes.SPLASH_ROUTE, page: () => SplashPage()),
    GetPage(name: Routes.ONBOARD_ROUTE, page: () => OnBoardingPage()),
    GetPage(
        name: Routes.AUTH_ROUTE,
        page: () => AuthPage(),
        bindings: [AuthPageBinding()]),
    GetPage(
        name: Routes.HOME_ROUTE,
        page: () => MyHomePage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.LOGIN_ROUTE,
        page: () => LoginPage(),
        bindings: [LoginBinding()]),
    GetPage(
        name: Routes.SIGNUP_ROUTE,
        page: () => SignupPage(),
        bindings: [SignupBinding()]),
  ];
}
