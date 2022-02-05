import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/reset_passward.dart';
import 'package:shop_app/models/verify_code_model.dart';
import 'package:shop_app/models/verify_email_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(
    this.loginModel,
  );
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final ShopLoginModel loginModel;

  ShopRegisterErrorState(
    this.loginModel,
  );
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}

class SendCodeLoading extends ShopRegisterStates {}

class SendCodeSuccess extends ShopRegisterStates {
  VerifyEmailModel verifyemailmodel;

  SendCodeSuccess(
    this.verifyemailmodel,
  );
}

class SendCodeError extends ShopRegisterStates {
  VerifyEmailModel verifyemailmodel;
  SendCodeError(
    this.verifyemailmodel,
  );
}

class VerifyCodeLoading extends ShopRegisterStates {}

class VerifyCodeSuccess extends ShopRegisterStates {
  final VerifyCodeModel model;

  VerifyCodeSuccess(
    this.model,
  );
}

class VerifyCodeError extends ShopRegisterStates {}

class ResetPasswardLoading extends ShopRegisterStates {}

class ResetPasswardSuccess extends ShopRegisterStates {
  final ResetPasswardModel model;

  ResetPasswardSuccess(
    this.model,
  );
}

class ResetPasswardError extends ShopRegisterStates {}
