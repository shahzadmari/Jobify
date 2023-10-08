import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:iec_project/models/user_model.dart';

class CompanyData extends GetxController {
  String? uid;
  late FirebaseFirestore reference;
  List<Companies> companies = <Companies>[];
  bool isloading = false;
  @override
  void onInit() {
    super.onInit();
    uid = FirebaseAuth.instance.currentUser!.uid;
    reference = FirebaseFirestore.instance;
  }

  Future<void> getData() async {
    try {
      QuerySnapshot words = await reference.collection("companies").get();
      companies.clear();
      for (var word in words.docs) {
        companies.add(Companies(
            bio: word['bio'],
            category: word['category'],
            contact: word['contact'],
            email: word['email'],
            name: word['name'],
            url: word['url']));
      }

      isloading = true;
      update();
    } catch (e) {
      Get.snackbar('error', e.toString());
    }
  }
}
