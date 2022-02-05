abstract class AppStates {}

class AppInit extends AppStates {}

class LoginLoading extends AppStates {}

class LoginSuccess extends AppStates {
  final loginModel;

  LoginSuccess(this.loginModel);
}

class LoginError extends AppStates {
  final error;
  final loginModel;
  LoginError(this.error, this.loginModel);
}

class ChangePassVisbility extends AppStates {}
