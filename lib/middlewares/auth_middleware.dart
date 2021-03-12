import 'package:firetest/routes/router.dart';
import 'package:firetest/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  redirect(String route) {
    final authService = Get.find<AuthService>();
    return authService.user == null
        ? null
        : RouteSettings(name: Routes.LOGIN_ROUTE);
  }
}
