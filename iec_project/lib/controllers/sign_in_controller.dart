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
      final result = user;
      if (result != null) {
        // dialog("SignIn Successful", context);
        dialog("signed in ", context);
      }
    } on FirebaseAuthException catch (e) {
      dialog(e.message!, context);
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
