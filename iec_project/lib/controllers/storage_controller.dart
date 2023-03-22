import 'package:cloud_firestore/cloud_firestore.dart';

uploadData(String name, final uid, String email) async {
  final data = <String, String>{"name": name, "email": email};
  FirebaseFirestore db = FirebaseFirestore.instance;
  db.collection("seekers").doc(uid).set(data);
}
