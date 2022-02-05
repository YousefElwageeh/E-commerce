// ignore_for_file: non_constant_identifier_names

class CategoriesModel {
  late bool status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int current_page;
  List<DataModel>? data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) {
      data!.add(DataModel.fromJson(e));
    });
  }
}

class DataModel {
  late int id;
  String? name;
  String? image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
