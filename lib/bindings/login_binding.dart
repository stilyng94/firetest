import 'package:firetest/controllers/google_auth_controller.dart';
import 'package:firetest/remote_data_sources/google_auth_remote_source.dart';
import 'package:firetest/repositories/google_auth_repository.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GoogleAuthController>(() => GoogleAuthController(
        iGoogleAuthRepository: GoogleAuthRepository(GoogleAuthRemoteSource())));
  }
}
