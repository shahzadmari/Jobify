import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iec_project/models/post_models.dart';

class GetPostsController extends GetxController {
  List<PostsModel> posts = [];
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
      QuerySnapshot words = await postRef!.get();
      posts.clear();
      for (var value in words.docs) {
        posts.add(PostsModel.fromMap(value));
      }
      isLoading = true;
      update();
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }
}
