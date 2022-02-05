import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';

import 'package:shop_app/module/shop/Search/states.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/shared/const.dart';
import 'package:shop_app/shared/dio/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInit());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;
  void Search({
    required String searchText,
  }) {
    emit(SearchLoadingStates());
    DioHelper.postdata(url: SEARCH, token: token, data: {
      'text': searchText,
    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessStates());
      print(value.data);
    }).catchError((e) {
      print(e.toString());
      emit(SearchErrorStates());
    });
  }
}
