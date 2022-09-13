// ignore_for_file: unnecessary_new, unnecessary_getters_setters, prefer_typing_uninitialized_variables

class VerifyEmailModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  VerifyEmailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? university;
  String? emailVerifiedAt;
  int? active;
  int? type;
  var verifyCode;
  var _deletedAt;

  get deletedAt => _deletedAt;

  set deletedAt(deletedAt) {
    _deletedAt = deletedAt;
  }

  String? createdAt;
  String? updatedAt;
  var googleId;
  var facebookId;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    university = json['university'];
    emailVerifiedAt = json['email_verified_at'];
    active = json['active'];
    type = json['type'];
    verifyCode = json['verify_code'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    googleId = json['google_id'];
    facebookId = json['facebook_id'];
    token = json['token'];
  }
}
