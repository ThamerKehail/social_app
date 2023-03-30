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

class UserUpdateLoadingState extends EditProfileState {}

class UserUpdateErrorState extends EditProfileState {}

class GetUserDataSuccessState extends EditProfileState {}

class GetUserDataErrorState extends EditProfileState {}
