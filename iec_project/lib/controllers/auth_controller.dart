import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:iec_project/Firebase/auth_Service.dart';
// import 'package:iec_project/utils/constants.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:iec_project/pages/home_page.dart';
import 'package:iec_project/pages/job_seekers.dart';
import 'package:iec_project/pages/sign_in.dart';
import 'package:iec_project/pages/splash_screen.dart';
import 'package:iec_project/pages/user_options.dart';

class Authcontroller extends GetxController {
  static Authcontroller instance = Get.find();

  late Rx<User?> _user; //fire base user which store details of current user
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    //it is called when instance of controller initiated
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(
        auth.currentUser); //assigned values of current user to modal user
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen); //it listens for the changes of user
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => SplashScreen());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar("about user", "user message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("account creation failed"),
          messageText: Text(e.toString()));
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("about user", "user message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("sign in failed"),
          messageText: Text(e.toString()));
      print(e.message);
    } catch (e) {
      print(e);
    }
  }
}

Future<String> uploadImage(File _image) async {
  String url;
  String imgId = DateTime.now().microsecondsSinceEpoch.toString();
  //reference to firebase storage
  Reference ref = FirebaseStorage.instance.ref().child("users$imgId");
  await ref.putFile(_image);
  url = await ref.getDownloadURL();
  return url;
}

Future<String> uploadUserImage(File _image) async {
  String url;
  String imgId = DateTime.now().microsecondsSinceEpoch.toString();
  //reference to firebase storage
  Reference ref =
      FirebaseStorage.instance.ref().child("SeekerImages").child("users$imgId");
  await ref.putFile(_image);
  url = await ref.getDownloadURL();
  return url;
}
