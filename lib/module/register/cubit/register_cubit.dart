import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/models/reset_passward.dart';
import 'package:shop_app/models/verify_code_model.dart';
import 'package:shop_app/models/verify_email_model.dart';
import 'package:shop_app/module/register/cubit/register_cubit_states.dart';

import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postdata(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(
        loginModel!,
      ));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(
        loginModel!,
      ));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopRegisterChangePasswordVisibilityState());
  }

//  RESET PASSWARD & Verify email
  late VerifyEmailModel model;
  void sendCode({
    required String Email,
  }) {
    emit(SendCodeLoading());
    DioHelper.postdata(url: SEND_CODE, data: {
      'email': Email,
    }).then((value) {
      model = VerifyEmailModel.fromJson(value.data);
      emit(SendCodeSuccess(model));
    }).catchError((e) {
      print(e.toString());
      emit(SendCodeError(model));
    });
  }

  late VerifyCodeModel verfiyCode;
  void VerfiyCode({
    required String? code,
    required String? email,
  }) {
    emit(ResetPasswardLoading());
    print(email);
    print(code);
    DioHelper.postdata(url: VERIFY_CODE, data: {
      'email': email,
      'code': code,
    }).then((value) {
      verfiyCode = VerifyCodeModel.fromJson(value.data);
      emit(VerifyCodeSuccess(verfiyCode));
    }).catchError((e) {
      print(e.toString());
      emit(VerifyCodeError());
    });
  }

  late ResetPasswardModel ResetPassward;
  void reset_passward({
    required email,
    required code,
    required password,
  }) {
    emit(ResetPasswardLoading());
    DioHelper.postdata(url: RESET_PASSWARD, data: {
      'email': email,
      'code': code,
      'password': password,
    }).then((value) {
      ResetPassward = ResetPasswardModel.fromJson(value.data);
      emit(ResetPasswardSuccess(ResetPassward));
    }).catchError((E) {
      print(E.toString());
      emit(ResetPasswardError());
    });
  }
}
