import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:iec_project/utils/constants.dart';

class AuthService {
  final FirebaseAuth firebaseAuth;

  AuthService({required this.firebaseAuth});

  Future<User?> signin(
      String email, String password, BuildContext context) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
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

  Future<User?> Singup(String email, password, BuildContext context) async {
    try {
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      dialog(e.message!, context);
    }
  }

  Future<void> signOut() async {
    final credential = await firebaseAuth.signOut();
  }
}
