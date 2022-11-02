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
