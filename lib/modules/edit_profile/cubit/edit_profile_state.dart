part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitialState extends EditProfileState {}

class EditProfileImageSuccessState extends EditProfileState {}

class EditProfileImageErrorState extends EditProfileState {}

class EditProfileCoverSuccessState extends EditProfileState {}

class EditProfileCoverErrorState extends EditProfileState {}

class UploadProfileImageSuccessState extends EditProfileState {}

class UploadProfileImageErrorState extends EditProfileState {}
