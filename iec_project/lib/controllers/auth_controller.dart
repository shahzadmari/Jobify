import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:iec_project/Firebase/auth_Service.dart';
import 'package:iec_project/utils/constants.dart';

class Authcontroller {
  final AuthService _authService =
      AuthService(firebaseAuth: FirebaseAuth.instance);

  Future<void> login(
      String password, String email, BuildContext context) async {
    final result = await _authService.signin(email, password, context);
    if (result != null) {
      dialog("succesfull Authenticated", context);
    }
  }

  Future<void> signUp(
      String password, String email, BuildContext context) async {
    final result = await _authService.Singup(email, password, context);
    if (result != null) {
      dialog("Registered Successfully ", context);
    }
  }
}
