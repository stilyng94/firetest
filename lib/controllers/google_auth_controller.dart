import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetest/repositories/google_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class GoogleAuthController extends GetxController {
  final IGoogleAuthRepository iGoogleAuthRepository;

  GoogleAuthController({@required this.iGoogleAuthRepository})
      : assert(iGoogleAuthRepository != null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  final _passwordController =
      Rx<TextEditingController>(TextEditingController());
  final _emailController = Rx<TextEditingController>(TextEditingController());

  TextEditingController get passwordController => _passwordController.value;
  TextEditingController get emailController => _emailController.value;

  Future<void> signInOrUpWithGoogle() async {
    await this.iGoogleAuthRepository.signInOrUpWithGoogle(_googleSignIn);
    return;
  }

  Future<void> createUserWithEmailAndPassword() async {
    await iGoogleAuthRepository.createUserWithEmailAndPassword(
        _auth, emailController.text, passwordController.text);
    //! Success go to login page
    return;
  }

  Future<void> loginWithEmailOrPassword() async {
    await iGoogleAuthRepository.loginWithEmailAndPassword(
        _auth, emailController.text, passwordController.text);
    //! Success go to login page
    return;
  }

  Future<void> logOut() async {
    return iGoogleAuthRepository.googleLogOut(_googleSignIn);
  }

  Future<void> signInOrUpWithApple() async {
    await iGoogleAuthRepository.signInOrUpWithApple();
    return;
  }

  @override
  void onClose() {
    _passwordController.close();
    _emailController.close();
    super.onClose();
  }
}
