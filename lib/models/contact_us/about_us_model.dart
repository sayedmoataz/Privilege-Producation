// ignore_for_file: unnecessary_new

class AboutUsModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;
  bool? check;

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    check = json['check'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? about;
  String? whatsPhone;
  String? createdAt;
  String? updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    about = json['about'];
    whatsPhone = json['whats_phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
