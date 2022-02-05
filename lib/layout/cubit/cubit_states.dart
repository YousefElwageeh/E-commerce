// ignore_for_file: non_constant_identifier_names

import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopInit extends ShopStates {}

class ChangeBottomNavigator extends ShopStates {}

class ChangeBottomDeatiles extends ShopStates {}

class ShopLoadingState extends ShopStates {}

class ShopGetDataSuccess extends ShopStates {}

class ShopGetDataError extends ShopStates {
  final String Error;

  ShopGetDataError(this.Error);
}

class ShopGetCategoriesDataSuccess extends ShopStates {}

class ShopGetCategoriesDataError extends ShopStates {
  final Error;

  ShopGetCategoriesDataError(this.Error);
}

class ShopChangeFavorites extends ShopStates {}

class ShopChangeFavoritesSuccess extends ShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccess(this.model);
}

class ShopChangeFavoritesError extends ShopStates {
  final String Error;

  ShopChangeFavoritesError(this.Error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserDataState extends ShopStates {}

class ShopSuccessGetUserDataState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates {
  final ShopLoginModel model;

  ShopErrorUpdateUserState(this.model);
}

class ShopChangeShared extends ShopStates {}

class ShopChangelang extends ShopStates {}
