// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

class InstructorModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  InstructorModel.fromJson(Map<String, dynamic> json) {
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
  var university;
  var emailVerifiedAt;
  int? active;
  int? type;
  var verifyCode;
  var facebookId;
  var googleId;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  int? coursesCount;

  //var rate;
  List<Courses> courses = [];

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
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    coursesCount = json['courses_count'];
    //rate = json['rate'];
    if (json['courses'] != null) {
      json['courses'].forEach((v) {
        courses.add(new Courses.fromJson(v));
      });
    }
  }
}

class Courses {
  int? id;
  String? name;
  String? photo;
  int? price;
  int? realPrice;
  int? view;

  //var rate;
  String? description;
  int? term;
  int? type;
  int? active;
  String? createdAt;

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    realPrice = json['real_price'];
    view = json['view'];
    //rate = json['rate'];
    description = json['description'];
    term = json['term'];
    type = json['type'];
    active = json['active'];
    createdAt = json['created_at'];
  }
}
