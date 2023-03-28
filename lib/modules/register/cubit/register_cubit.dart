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
    print("Register");
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
    );
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
