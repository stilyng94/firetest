import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rx<User> _firebaseUser = Rx<User>();
  User get user => _firebaseUser.value;

  AuthService init() {
    _firebaseUser.bindStream(_auth.idTokenChanges());
    return this;
  }
}
