abstract class LoginStates {}

class LoginInitState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}
