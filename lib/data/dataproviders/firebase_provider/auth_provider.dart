import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used";
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong password";
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests to log into this account.";
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";
        default:
          return "Register failed. Please try again.";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          return "Email already used. Go to login page.";
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          return "Wrong email/password combination.";
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          return "No user found with this email.";
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          return "User disabled.";
        case "ERROR_TOO_MANY_REQUESTS":
          return "Too many requests to log into this account.";
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          return "Email address is invalid.";
        default:
          return "Register failed. Please try again.";
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
