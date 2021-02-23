import 'package:firebase_auth/firebase_auth.dart';
import 'package:firetest/utils/apple_oauth_util.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class IGoogleAuthRemoteSource {
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

class GoogleAuthRemoteSource implements IGoogleAuthRemoteSource {
  @override
  Future<UserCredential> createUserWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      throw e;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  Future<User> loginWithEmailAndPassword(
      FirebaseAuth firebaseAuth, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong login credentials.');
      }
      throw e;
    }
  }

  @override
  Future<void> logOut(FirebaseAuth firebaseAuth) async {
    return await firebaseAuth.signOut();
  }

  @override
  Future<UserCredential> signInOrUpWithGoogle(GoogleSignIn googleSignIn) async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> googleLogOut(GoogleSignIn googleSignIn) async {
    await googleSignIn.signOut();
    return;
  }

  @override
  Future<UserCredential> signInOrUpWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  @override
  Future<void> appleLogout() async {
    return FirebaseAuth.instance.signOut();
  }
}
