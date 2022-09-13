// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

class UserCoursesModel {
  bool? status;
  int? code;
  String? msg;
  List<Data> data = [];

  UserCoursesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
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
  Pivot? pivot;
  Level? level;
  Instructor? instructor;
  List<Materials> materials = [];

  Data.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    if (json['materials'] != null) {
      json['materials'].forEach((v) {
        materials.add(new Materials.fromJson(v));
      });
    }
  }
}

class Pivot {
  int? userId;
  int? courseId;
  String? createdAt;
  String? updatedAt;

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Level {
  int? id;
  String? name;
  int? active;

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    active = json['active'];
  }
}

class Instructor {
  int? id;
  String? name;

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Materials {
  int? courseId;
  int? id;
  String? name;
  String? video;
  String? file;
  var description;
  String? price;
  int? viewNumber;

  Materials.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    id = json['id'];
    name = json['name'];
    video = json['video'];
    file = json['file'];
    description = json['description'];
    price = json['price'];
    viewNumber = json['view_number'];
  }
}
