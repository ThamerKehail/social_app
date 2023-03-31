part of 'social_cubit.dart';

@immutable
abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialChangeBottomNavState extends SocialState {}

class SocialAddPostState extends SocialState {}

//create Post
class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class UploadPostImageSuccessState extends SocialState {}

class UploadPostImageErrorState extends SocialState {}

class GetPostImageSuccessState extends SocialState {}

class GetPostImageErrorState extends SocialState {}

class RemovePostImageState extends SocialState {}
