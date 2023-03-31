import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/modules/chats/chat_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';

import '../../models/user_model.dart';
import '../../shared/network/local/cache_helper.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  TextEditingController post = TextEditingController();
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatScreen(),
    const SizedBox(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> screenTitle = [
    "News Feed",
    "Chat",
    '',
    "Users",
    "Settings",
  ];

  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(SocialAddPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

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

  File? postImage;
  String? imageUrl;
  final picker = ImagePicker();

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPostImageSuccessState());
    } else {
      print("No image selected");
      emit(GetPostImageErrorState());
    }
  }

  void uploadPosImage() {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;

        emit(UploadPostImageSuccessState());

        createPost(postImage: value);

        print(value);
      }).catchError((error) {
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({String? postImage}) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      userName: userModel.userName,
      uid: userModel.uid,
      image: userModel.image,
      text: post.text,
      dateTme: DateTime.now().toString(),
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }
}
