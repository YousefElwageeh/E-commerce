// ignore_for_file: camel_case_types

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/module/Register%20as%20a%20seller/cubit/states.dart';
import 'package:shop_app/module/Register%20as%20a%20seller/register_as_a_seller.dart';

class Register_As_cubit extends Cubit<Shop_Register_AS_States> {
  Register_As_cubit() : super(Shop_Register_AS_InitialState());
  static Register_As_cubit get(context) => BlocProvider.of(context);

  PickedFile? imageFile;
  void take_photo() {
    imageFile = pickedFile;
    emit(ChangeImage());
  }

  void delete_photo() {
    imageFile = null;
    emit(DeletImage());
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswardIcon());
  }
}
