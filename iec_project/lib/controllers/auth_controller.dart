// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:iec_project/Firebase/auth_Service.dart';
// import 'package:iec_project/utils/constants.dart';

// class Authcontroller {
//   final AuthService _authService =
//       AuthService(firebaseAuth: FirebaseAuth.instance);

//   Future<void> signUp(
//       String password, String email, BuildContext context) async {
//     final result = await _authService.Singup(email, password, context);
//     if (result != null) {
//       dialog("Registered Successfully ", context);
//     }
//   }
// }

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File _image) async {
  String url;
  String imgId = DateTime.now().microsecondsSinceEpoch.toString();
  //reference to firebase storage
  Reference ref = FirebaseStorage.instance.ref().child("users$imgId");
  await ref.putFile(_image);
  url = await ref.getDownloadURL();
  return url;
}
