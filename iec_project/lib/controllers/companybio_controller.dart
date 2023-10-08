import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iec_project/pages/home_page.dart';

class CompanyController extends GetxController {
  static CompanyController instance = Get.find();
  TextEditingController? bioController, contactController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late FirebaseFirestore reference;
  String? uid;
  RxBool isUploading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    bioController = TextEditingController();
    nameController.text = FirebaseAuth.instance.currentUser!.displayName!;
    emailController.text = FirebaseAuth.instance.currentUser!.email!;
    contactController = TextEditingController();
    reference = FirebaseFirestore.instance;
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> uploadData(String url) async {
    FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
    await reference.collection('companies').doc(uid).set({
      'category': true,
      'name': nameController!.text,
      'bio': bioController!.text,
      'email': emailController!.text,
      'contact': contactController!.text,
      'url': url
    }).whenComplete(() {
      isUploading.value = false;
      Get.back();
      Get.offAll(HomePage());

      Get.snackbar("data writed", "data is written",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text("data successfully uploaded"),
          messageText: Text("Data uploaded succcesfully"));
    }).catchError((onError) {
      isUploading.value = false;
      Get.back();
      Get.snackbar("failed", "failed", messageText: Text(onError.toString()));
    });
    ;
  }

  Future<String> uploadCompanyImage(File _image) async {
    isUploading.value = true;
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    //reference to firebase storage
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("CompanyImages")
        .child("users$imgId");
    await ref.putFile(_image);
    url = await ref.getDownloadURL();
    return url;
  }
}
