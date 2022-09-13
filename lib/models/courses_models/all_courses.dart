// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

class AllCoursesModel {
  bool? status;
  int? code;
  String? msg;
  List<Data> data = [];

  AllCoursesModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  int? subjectId;
  int? instructorId;
  int? active;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  List<Materials> materials = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    realPrice = json['real_price'];
    description = json['description'];
    subjectId = json['subject_id'];
    instructorId = json['instructor_id'];
    active = json['active'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
  }
}

class Materials {
  int? courseId;
  int? id;
  String? name;
  String? video;
  String? file;
  String? description;
  String? price;

  Materials.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    id = json['id'];
    name = json['name'];
    video = json['video'];
    file = json['file'];
    description = json['description'];
    price = json['price'];
  }
}
