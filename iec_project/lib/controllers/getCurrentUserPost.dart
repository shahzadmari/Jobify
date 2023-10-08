import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:iec_project/models/post_models.dart';

class GetCurrentPostsController extends GetxController {
  List<PostsModel> currentposts = [];
  CollectionReference? postRef;
  bool isLoading = false;
  String? uid;

  @override
  void onInit() {
    super.onInit();
    postRef = FirebaseFirestore.instance.collection('CompanyPosts');
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  Future<void> getPosts() async {
    try {
      QuerySnapshot words = await postRef!
          .where("ownerId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      currentposts.clear();

      for (var value in words.docs) {
        currentposts.add(PostsModel.fromMap(value));
      }
      print(currentposts[0].username);

      isLoading = true;
      update();
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }
}
