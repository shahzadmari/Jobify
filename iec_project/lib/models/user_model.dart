import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  UserModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    this.albumId = json["albumId"];
    this.id = json["id"];
    this.title = json["title"];
    this.url = json["url"];
    this.thumbnailUrl = json["thumbnailUrl"];
  }
}

class Seekers {
  String? name;
  String? bio;
  String? experience;
  var skills;
  String? email;
  String? contact;
  String? url;

  Seekers(
      {this.name,
      this.bio,
      this.experience,
      this.skills,
      this.email,
      this.contact,
      this.url});

  Seekers.fromMap(DocumentSnapshot data) {
    name = data['name'];
    bio = data["bio"];
    experience = data["experience"];
    skills = data["skills"];
    email = data["email"];
    contact = data["contact"];
    url = data["url"];
  }

  Map<String, dynamic> ToFirestore() {
    return {
      if (name != null) "name": name,
      if (bio != null) "bio": bio,
      if (experience != null) "experience": experience,
      if (skills != null) "skills": FieldValue.arrayUnion([skills]),
      if (email != null) "email": email,
      if (contact != null) "contact": contact,
      if (url != null) "url": url
    };
  }
}

class Companies {
  String? bio, contact, email, name, url;
  bool? category;
  Companies(
      {this.bio, this.category, this.contact, this.email, this.name, this.url});
}
