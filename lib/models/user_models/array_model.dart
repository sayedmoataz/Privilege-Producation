// ignore_for_file: unnecessary_new

class UserArrayModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  UserArrayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<int> myRates = [];
  List<int> myCourses = [];
  List<int> myMaterials = [];
  List<int> myFavorite = [];

  Data.fromJson(Map<String, dynamic> json) {
    myRates = json['my_rates'].cast<int>();
    myCourses = json['my_courses'].cast<int>();
    myMaterials = json['my_materials'].cast<int>();
    myFavorite = json['my_favorite'].cast<int>();
  }
}
