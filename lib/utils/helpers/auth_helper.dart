import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();

  static final AuthHelper authHelper = AuthHelper._();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> SignUpuser(
      {required String email, required String password}) async {
    Map<String, dynamic> response = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      response['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          response['error'] = "this service is disabled by admin right now.";
        case "email-already-in-use":
          response['error'] = "password must be minimum 6 characters";
        default:
          response['error'] = e.code;
      }
    }
    return response;
  }

  Future<Map<String, dynamic>> SignInuser(
      {required String email, required String password}) async {
    Map<String, dynamic> response = {};
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      response['user'] = user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "admin-restricted-operation":
          response['error'] = "this service is disabled by admin right now.";
        case "email-already-in-use":
          response['error'] = "password must be minimum 6 characters";
        default:
          response['error'] = e.code;
      }
    }
    return response;
  }

  Future<void> sighOutUser() async {
    await firebaseAuth.signOut();
  }

  Future<Map<String, dynamic>> anonymousLogin() async {
    Map<String, dynamic> response = {};

    try {
      UserCredential? userCredential = await firebaseAuth.signInAnonymously();

      User? user = userCredential.user;
      response['user'] = user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "admin-restricted-operation") {
        response['error'] = "this services is disabled by admin right now";
      } else {
        response['error'] = e.code;
      }
    }
    return response;
  }
}
