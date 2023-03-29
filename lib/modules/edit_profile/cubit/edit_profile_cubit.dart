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

  late UserModel userModel;
  void getUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uid'))
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel.email);
      print(value.data());
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

  String imageUrl = '';
  void uploadProfileImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        emit(UploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  String coverImageUrl = '';
  void uploadCoverImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(UploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uid)
        .update(data)
        .then((value) {})
        .catchError(
          (error) {},
        );
  }
}
