import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/register/cubit/register_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitState());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  late final String uid;
  userRegister() {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uid = value.user!.uid;
      userCreate();
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error));
    });
  }

  userCreate() {
    UserModel user = UserModel(
        email: email.text,
        phone: phone.text,
        uid: uid,
        userName: userName.text,
        isEmailVerified: false,
        image:
            'https://www.bing.com/th?id=OIP.NfJCEFT-pMf8Me5cyKfgRgHaFH&w=150&h=104&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
        bio: 'write your bio..',
        cover:
            'https://rfonexus.com/wp-content/uploads/2021/08/developer_1628330394-1068x709.jpg');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(user.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}
