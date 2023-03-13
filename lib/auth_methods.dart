import 'package:deardiary/providers/firestore_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class AuthMethods {
  final FirestoreProvider _fsp;

  AuthMethods(FirestoreProvider fsp) : _fsp = fsp;

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _fsp.fireauth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The email address is badly formatted.';
      } else if (e.code == 'user-disabled') {
        return 'The user corresponding to the given email has been disabled.';
      } else if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return 'Invalid email or password.';
      }
    }
  }

  Future<String> registerWithEmailAndPassword(String email, String password,
      String username, String dateOfBirth) async {
    try {
      UserCredential user = await _fsp.fireauth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserModel userLocal = UserModel(
        userID: user.user!.uid,
        userName: username,
        userDob: dateOfBirth,
        email: email,
      );

      await _fsp.firestore
          .collection('users')
          .doc(user.user!.uid)
          .set(userLocal.toJson())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is badly formatted.';
      } else if (e.code == 'operation-not-allowed') {
        return 'Email/password accounts are not enabled.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else {
        return 'Invalid email or password.';
      }
    } catch (e) {
      return 'Unknown error.';
    }
  }
}
