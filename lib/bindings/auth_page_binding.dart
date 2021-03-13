import 'package:firetest/controllers/auth_controller.dart';
import 'package:firetest/remote_data_sources/auth_remote_source.dart';
import 'package:firetest/repositories/auth_repository.dart';
import 'package:get/get.dart';

class AuthPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(
        iGoogleAuthRepository: AuthRepository(AuthRemoteSource())));
  }
}
