import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:iec_project/models/user_model.dart';
import 'package:iec_project/pages/home_page.dart';

class FirestoreController extends GetxController {
  static FirestoreController instance = Get.find();
  bool isLoading = false;
  TextEditingController? nameController,
      bioController,
      skillController,
      contactController,
      emailController;
  SingleValueDropDownController? expController;
  List<String> skills = [];
  MultiValueDropDownController? mController;
  late FirebaseFirestore reference;
  List<Seekers> seekers = <Seekers>[];

  String? uid;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    bioController = TextEditingController();
    skillController = TextEditingController();
    contactController = TextEditingController();
    emailController = TextEditingController();
    expController = SingleValueDropDownController();
    mController = MultiValueDropDownController();
    reference = FirebaseFirestore.instance;
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> uploadData(String url) async {
    reference
        .collection('seekers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'name': nameController!.text,
      'bio': bioController!.text,
      'experience': expController!.dropDownValue!.name,
      'email': emailController!.text,
      'number': contactController!.text,
      'skills': skills,
      'url': url
    }).whenComplete(() {
      Get.offAll(HomePage());
      Get.snackbar("data writed", "data is written",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("data successfully uploaded"),
          messageText: Text("Data uploaded succcesfully"));
    }).catchError((onError) {
      Get.back();
      Get.snackbar("failed", "failed", messageText: Text(onError.toString()));
    });
  }

  Future<void> getdata() async {
    try {
      QuerySnapshot words = await reference.collection('seekers').get();
      seekers.clear();
      for (var words in words.docs) {
        seekers.add(Seekers(
            name: words['name'],
            bio: words['bio'],
            experience: words['experience'],
            skills: words['skills'],
            email: words['email'],
            contact: words['number'],
            url: words['url']));
      }
      isLoading = true;
      update();
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
