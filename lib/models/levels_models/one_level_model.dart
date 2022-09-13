// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

class OneLevelModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  OneLevelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  int? collegeId;
  College? college;
  List<Courses> courses = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    collegeId = json['college_id'];
    college =
        json['college'] != null ? new College.fromJson(json['college']) : null;
    if (json['courses'] != null) {
      json['courses'].forEach((v) {
        courses.add(new Courses.fromJson(v));
      });
    }
  }
}

class College {
  int? id;
  String? name;

  College.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Courses {
  int? id;
  String? name;
  String? photo;
  int? price;
  int? realPrice;
  int? view;
  var rate;
  String? description;
  int? term;
  int? type;
  int? active;
  String? createdAt;
  int? materialsCount;
  Instructor? instructor;

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    realPrice = json['real_price'];
    view = json['view'];
    rate = json['rate'];
    description = json['description'];
    term = json['term'];
    type = json['type'];
    active = json['active'];
    createdAt = json['created_at'];
    materialsCount = json['materials_count'];
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
  }
}

class Instructor {
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

  Instructor.fromJson(Map<String, dynamic> json) {
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
  }
}
