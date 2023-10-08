import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uuid/uuid.dart';

class PostController extends GetxController {
  String? PostId;
  TextEditingController? title, desc, Loc;
  CollectionReference? postref;
  String? CurrentUser;
  DateTime? datetime;
  RxBool isUploading = false.obs;
  bool checkdoc = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    PostId = Uuid().v4();
    postref = FirebaseFirestore.instance.collection('CompanyPosts');
    CurrentUser = FirebaseAuth.instance.currentUser!.uid;
    ;
    title = TextEditingController();
    desc = TextEditingController();
    Loc = TextEditingController();
    datetime = DateTime.now();
    checkDoc();
  }

  Future<void> uploadPost(BuildContext context) async {
    isUploading.value = true;

    try {
      await postref!.add({
        "ownerId": CurrentUser,
        "username": FirebaseAuth.instance.currentUser!.displayName,
        "title": title!.text,
        "description": desc!.text,
        "location": Loc!.text,
        "timestamp": datetime,
        "email": FirebaseAuth.instance.currentUser!.email
      }).whenComplete(() {
        Navigator.of(context).pop();
        Get.snackbar("Success", "post have been uploaded");
      });
    } catch (e) {
      Get.snackbar("uploading faliled", e.toString());
    }
    //.whenComplete(() {
    //   Navigator.of(context).pop();
    //   Get.snackbar("Success", "post have been uploaded");
    // }).onError((error, stackTrace) {
    //   isUploading.value = false;
    //   Get.snackbar("failed", error.toString());

    // });
  }

  Future<void> checkDoc() async {
    var userDoc = await FirebaseFirestore.instance
        .collection("companies")
        .doc(CurrentUser)
        .get();
    if (userDoc.exists) {
      Map<String, dynamic>? map = userDoc.data() as Map<String, dynamic>?;
      if (map!.containsKey('category')) {
        checkdoc = map['category'];
        print(checkdoc);
        update();
      } else {
        print("does not contain it");
      }
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    title!.clear();
    desc!.clear();
    Loc!.clear();
  }
}
