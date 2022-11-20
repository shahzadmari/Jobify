import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/utils/constants.dart';

class SignUpController {
  User? user;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp(
      String name, String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = credential.user;

      user!.updateDisplayName(name);

      if (user != null) {
        // dialog("SignIn Successful", context);
        dialog("registered user ", context);
      }
    } on FirebaseAuthException catch (e) {
      dialog(e.message!, context);
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}
