import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/module/Login/cubit/cubit_states.dart';
import 'package:shop_app/module/shop/categories.dart';
import 'package:shop_app/module/shop/favorites.dart';

import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/const.dart';

import 'package:shop_app/shared/dio/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInit());
  static AppCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;
  void login({
    required String email,
    required String pass,
  }) {
    emit(LoginLoading());
    DioHelper.postdata(
      url: LOGIN,
      data: {
        'email': email,
        'password': pass,
      },
    ).then((value) async {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(LoginSuccess(loginModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginError(onError.toString(), loginModel));
    });
  }

  bool isPASS = false;

  void changeVisablityToPass() {
    isPASS = !isPASS;

    emit(ChangePassVisbility());
  }

  // void changelang() {
  //   arabic = !arabic;
  //   lang = arabic ? Locale("ar") : Locale("en");
  //   print(arabic);
  //   print(lang);
  //   emit(loginChangelang());
  // }
}
