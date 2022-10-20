import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/utils/constants.dart';

class SignInController {
  User? user;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = credential.user;
      if (user != null) {
        dialog("SignIn Successful", context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialog(e.message!, context);
      } else if (e.code == 'email-already-in-use') {
        dialog(e.message!, context);
      }
    } catch (e) {
      print(e);
    }
  }
}
