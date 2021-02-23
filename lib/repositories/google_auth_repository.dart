import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetest/remote_data_sources/google_auth_remote_source.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IGoogleAuthRepository {
  Future<UserCredential> signInOrUpWithGoogle(GoogleSignIn googleSignIn);
  Future<UserCredential> createUserWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password);
  Future<User> loginWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password);
  Future<void> logOut(FirebaseAuth firebaseAuth);
  Future<void> googleLogOut(GoogleSignIn googleSignIn);
  Future<UserCredential> signInOrUpWithApple();
  Future<void> appleLogout();
}

class GoogleAuthRepository implements IGoogleAuthRepository {
  final IGoogleAuthRemoteSource iGoogleAuthRemoteSource;

  GoogleAuthRepository(this.iGoogleAuthRemoteSource)
      : assert(iGoogleAuthRemoteSource != null);
  @override
  Future<UserCredential> signInOrUpWithGoogle(GoogleSignIn googleSignIn) {
    return iGoogleAuthRemoteSource.signInOrUpWithGoogle(googleSignIn);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password) async {
    return await iGoogleAuthRemoteSource.createUserWithEmailAndPassword(
        firebaseAuth, email, password);
  }

  @override
  Future<User> loginWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password) async {
    return await iGoogleAuthRemoteSource.loginWithEmailAndPassword(
        firebaseAuth, email, password);
  }

  @override
  Future<void> logOut(FirebaseAuth firebaseAuth) {
    return iGoogleAuthRemoteSource.logOut(firebaseAuth);
  }

  @override
  Future<void> googleLogOut(GoogleSignIn googleSignIn) async {
    return await iGoogleAuthRemoteSource.googleLogOut(googleSignIn);
  }

  @override
  Future<void> appleLogout() async {
    return await iGoogleAuthRemoteSource.appleLogout();
  }

  @override
  Future<UserCredential> signInOrUpWithApple() async {
    return await iGoogleAuthRemoteSource.signInOrUpWithApple();
  }
}
