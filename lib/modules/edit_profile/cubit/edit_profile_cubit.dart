import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());
  TextEditingController userName = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController phone = TextEditingController();

  late UserModel userModel;
  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uid'))
        .get()
        .then((value) {
      print("uid========${CacheHelper.getData(key: 'uid')}");
      userModel = UserModel.fromJson(value.data()!);
      userName.text = userModel.userName!;
      bio.text = userModel.bio!;
      phone.text = userModel.phone!;
      emit(GetUserDataSuccessState());
      print(userModel.email);
      print(value.data());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  File? image;
  File? coverImage;
  final picker = ImagePicker();
  static EditProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);

      emit(EditProfileImageSuccessState());
    } else {
      print("No image selected");
      emit(EditProfileImageErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(EditProfileCoverSuccessState());
    } else {
      print("No image selected");
      emit(EditProfileCoverErrorState());
    }
  }

  String? imageUrl;
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;

        emit(UploadProfileImageSuccessState());
        update();
        print(value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  String? coverImageUrl;
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(UploadProfileImageSuccessState());
        update();
        print(value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser() {
    if (coverImage != null && image != null) {
      print("cover and image");
      uploadCoverImage();
      uploadProfileImage();
    } else if (coverImage != null) {
      uploadCoverImage();
    } else if (image != null) {
      uploadProfileImage();
    } else {
      update();
    }
  }

  void update() {
    emit(UserUpdateLoadingState());
    UserModel user = UserModel(
      bio: bio.text.isEmpty ? userModel.bio : bio.text,
      image: imageUrl ?? userModel.image,
      isEmailVerified: false,
      cover: coverImageUrl ?? userModel.cover,
      email: userModel.email,
      phone: phone.text.isEmpty ? userModel.phone : phone.text,
      uid: userModel.uid,
      userName: userName.text.isEmpty ? userModel.userName : userName.text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .update(user.toMap())
        .then((value) {
      getUserData();
    }).catchError(
      (error) {
        emit(UserUpdateErrorState());
      },
    );
  }
}
