class UserModel {
  String? userName;
  String? email;
  String? phone;
  String? uid;
  bool? isEmailVerified;
  UserModel(
      {this.phone, this.uid, this.email, this.userName, this.isEmailVerified});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'uid': uid,
      'isEmailVerified': isEmailVerified,
    };
  }
}
