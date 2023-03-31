class PostModel {
  String? userName;
  String? uid;
  String? image;
  String? text;
  String? dateTme;
  String? postImage;
  PostModel({
    this.uid,
    this.userName,
    this.image,
    this.text,
    this.dateTme,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uid = json['uid'];
    image = json['image'];
    text = json['text'];
    dateTme = json['dateTme'];
    postImage = json['postImage'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'image': image,
      'text': text,
      'dateTme': dateTme,
      'postImage': postImage,
    };
  }
}
