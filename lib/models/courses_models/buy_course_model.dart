class BuyCourseModel {
  bool? status;
  int? code;
  String? msg;
  String? data;

  BuyCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }
}
