// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit_states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/module/shop/categories.dart';
import 'package:shop_app/module/shop/favorites.dart';
import 'package:shop_app/module/shop/home.dart';
import 'package:shop_app/module/shop/settings_screen.dart';

import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/component.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';
import 'package:shop_app/shared/shared%20prefance/cath_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInit());
  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> bottomScreens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  int CurrentIndex = 0;
  void ChangeIndex(int index) {
    CurrentIndex = index;
    emit(ChangeBottomNavigator());
  }

  int CurrentDeatiles = 0;
  void ChangeIndexDeatiles(int index) {
    CurrentDeatiles = index;
    emit(ChangeBottomDeatiles());
  }

  Map<int?, bool?> favorites = {};
  HomeModel? homeData;
  void ShopGetData() {
    emit(ShopLoadingState());
    DioHelper.getdata(url: HOME, token: token).then((value) {
      homeData = HomeModel.fromJason(
        value.data,
      );
      printFullText(homeData.toString());
      homeData!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopGetDataSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(ShopGetDataError(e));
    });
  }

  CategoriesModel? categoriesData;
  void GetCategoriesData() {
    DioHelper.getdata(url: CATEGORIES, token: token).then((value) {
      categoriesData = CategoriesModel.fromJson(
        value.data,
      );

      emit(ShopGetCategoriesDataSuccess());
    }).catchError((e) {
      print(e.toString());
      emit(ShopGetCategoriesDataError(e));
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void ChangeFavorites(int productId) {
    favorites[productId] = !(favorites[productId]!);

    emit(ShopChangeFavorites());
    DioHelper.postdata(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        favorites[productId] = !(favorites[productId]!);
      } else {
        getFavorites();
      }
      print(changeFavoritesModel.message);

      emit(ShopChangeFavoritesSuccess((changeFavoritesModel)));
    }).catchError((e) {
      favorites[productId] = !(favorites[productId]!);
      emit(ShopChangeFavoritesError(e.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getdata(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingGetUserDataState());

    DioHelper.getdata(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print('ana geeeeet');

      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      print(PROFILE);
      print(token);
      emit(ShopErrorGetUserDataState());
    });
  }

  ShopLoginModel? Model;
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putdata(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      Model = ShopLoginModel.fromJson(value.data);
      print(Model!.data!.email);
      getUserData();
      emit(ShopSuccessUpdateUserState());
    }).catchError((error) {
      print(error.toString());
      print(Model!.message!);
      emit(ShopErrorUpdateUserState(Model!));
    });
  }

  bool isdark = false;
  var AppMode;
  void ChangeAppTheme({
    bool? fromShared,
  }) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(ShopChangeShared());
    } else {
      isdark = !isdark;
      SharedHelper.saveData(key: 'isDark', value: isdark);
      emit(ShopChangeShared());
    }
  }

  bool arabic = false;
  void changelang({
    bool? DL,
  }) {
    if (DL != null) {
      arabic = DL;

      emit(ShopChangelang());
    } else {
      arabic = !arabic;
      emit(ShopChangelang());
    }
    SharedHelper.saveData(key: 'lang', value: arabic);
    emit(ShopChangelang());
    print(arabic);
  }
}
