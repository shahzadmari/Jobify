import 'package:cloud_firestore/cloud_firestore.dart';

class PostsModel {
  String? description, location, ownderId, title, username, email;
  Timestamp? timestamp;

  PostsModel(
      {this.description,
      this.location,
      this.ownderId,
      this.title,
      this.username});

  PostsModel.fromMap(DocumentSnapshot data) {
    description = data['description'];
    location = data['location'];
    ownderId = data['ownerId'];
    timestamp = data['timestamp'];
    title = data['title'];
    username = data['username'];
    email = data['email'];
  }
}
