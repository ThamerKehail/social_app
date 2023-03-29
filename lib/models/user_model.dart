class UserModel {
  String? userName;
  String? email;
  String? phone;
  String? uid;
  bool? isEmailVerified;
  String? image;
  String? cover;
  String? bio;
  UserModel({
    this.phone,
    this.uid,
    this.email,
    this.userName,
    this.isEmailVerified,
    this.image,
    this.cover,
    this.bio,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'cover': cover,
      'bio': bio,
    };
  }
}
