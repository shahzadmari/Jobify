// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// import 'package:iec_project/utils/constants.dart';

// class AuthService {
//   Future<User?> Singup(String email, password, BuildContext context) async {
//     try {
//       UserCredential credential = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     } on FirebaseAuthException catch (e) {
//       dialog(e.message!, context);
//     }
//   }

//   Future<void> signOut() async {
//     final credential = await firebaseAuth.signOut();
//   }
// }
