import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iec_project/pages/home_page.dart';

class SeekerUploadController extends GetxController {
  static SeekerUploadController instance = Get.find();
  TextEditingController? bioController, skillController, contactController;

  SingleValueDropDownController? expController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<String> skills = [];
  MultiValueDropDownController? mController;
  late FirebaseFirestore reference;
  String? uid;
  RxBool isUploading = false.obs;

  @override
  void onInit() {
    super.onInit();

    bioController = TextEditingController();
    skillController = TextEditingController();
    contactController = TextEditingController();
    nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
    emailController.text = FirebaseAuth.instance.currentUser!.email!;
    expController = SingleValueDropDownController();
    mController = MultiValueDropDownController();
    reference = FirebaseFirestore.instance;
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> uploadData(String url) async {
    FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
    await reference
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
      Get.back();
      Get.offAll(HomePage());
      isUploading.value = false;
      Get.snackbar("data writed", "data is written",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("data successfully uploaded"),
          messageText: Text("Data uploaded succcesfully"));
    }).catchError((onError) {
      Get.back();
      Get.snackbar("failed", "failed", messageText: Text(onError.toString()));
    });
  }

  Future<String> uploadUserImage(File _image) async {
    isUploading.value = true;
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    //reference to firebase storage
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("SeekerImages")
        .child("users$imgId");
    await ref.putFile(_image);
    url = await ref.getDownloadURL();
    return url;
  }
}
