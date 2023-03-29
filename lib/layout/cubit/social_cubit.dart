import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
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
  TextEditingController userName = TextEditingController();
  TextEditingController bio = TextEditingController();
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
}
