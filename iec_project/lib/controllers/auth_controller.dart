import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:iec_project/utils/constants.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:iec_project/pages/home_page.dart';

import 'package:iec_project/pages/splash_screen.dart';
import 'package:iec_project/pages/user_options.dart';

class Authcontroller extends GetxController {
  static Authcontroller instance = Get.find();
  RxBool isUploading = false.obs;
  late Rx<User?> _user; //fire base user which store details of current user
  FirebaseAuth auth = FirebaseAuth.instance;
  bool? first_time;
  @override
  void onReady() {
    //it is called when instance of controller initiated

    super.onReady();
    _user = Rx<User?>(
        auth.currentUser); //assigned values of current user to modal user
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen); //it listens for the changes of user
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const SplashScreen());
    } else if (user.displayName != null && first_time == true) {
      Get.offAll(() => const UserOptions());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      isUploading.value = true;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      first_time = true;
    } on FirebaseAuthException catch (e) {
      isUploading.value = false;
      Get.snackbar("about user", "user message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("account creation failed"),
          messageText: Text(e.toString()));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      isUploading.value = true;
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      first_time = false;
    } on FirebaseAuthException catch (e) {
      isUploading.value = false;
      Get.snackbar("about user", "user message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("sign in failed"),
          messageText: Text(e.toString()));
      print(e.message);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    isUploading.value = false;
    await auth.signOut();
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
