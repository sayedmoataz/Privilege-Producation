// ignore_for_file: unnecessary_new

class OneSubjectCollegeModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  OneSubjectCollegeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? photo;
  List<Courses> courses = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
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
  String? description;
  bool? active;
  String? createdAt;
  Instructor? instructor;

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    realPrice = json['real_price'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
  }
}

class Instructor {
  int? id;
  String? name;
  String? photo;

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }
}
