import 'package:flutter/material.dart';
import 'package:shop_app/layout/cubit/shop_cubit.dart';
import 'package:shop_app/module/Login/login_screen.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/shared%20prefance/cath_helper.dart';

String? token;

void signOut(context) {
  SharedHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

var emailController = TextEditingController();

//var Themes = Theme.of(context).textTheme.bodyText1;
const kDefaultPaddin = 20.0;
const kDefaultPadding = 24.0;
const kLessPadding = 10.0;
const kFixPadding = 16.0;
