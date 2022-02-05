class ResetPasswardModel {
  bool? status;
  String? message;

  ResetPasswardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
