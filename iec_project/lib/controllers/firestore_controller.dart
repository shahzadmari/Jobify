import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:iec_project/models/user_model.dart';

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
  List<Seekers> searchedSeekers = <Seekers>[];
  QuerySnapshot? searchresults;
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

  Future<void> searching_Data(String query) async {
    try {
      QuerySnapshot words = await reference
          .collection('seekers')
          .where("name", isGreaterThanOrEqualTo: query)
          .get();
      searchresults = words;
      for (var users in words.docs) {
        searchedSeekers.add(Seekers(
            name: users['name'],
            bio: users['bio'],
            experience: users['experience'],
            skills: users['skills'],
            email: users['email'],
            contact: users['number'],
            url: users['url']));
      }
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
