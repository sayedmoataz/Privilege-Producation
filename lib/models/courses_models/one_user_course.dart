// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables

import '/models/materials/one_material_model.dart';

class OneUserCourseModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  OneUserCourseModel.fromJson(Map<String, dynamic> json) {
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
  int? price;
  int? realPrice;
  int? view;
  var rate;
  String? description;
  int? active;
  String? createdAt;
  Pivot? pivot;
  List<DataOneMaterial> materials = [];
  Instructor? instructor;
  List<Comments> comments = [];
  Subject? subject;
  List<CourseView> courseView = [];
  List<Rates> rates = [];

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    price = json['price'];
    realPrice = json['real_price'];
    view = json['view'];
    rate = json['rate'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
    if (json['materials'] != null) {
      json['materials'].forEach((v) {
        materials.add(DataOneMaterial.fromJson(v));
      });
    }
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    if (json['comments'] != null) {
      json['comments'].forEach((v) {
        comments.add(new Comments.fromJson(v));
      });
    }
    subject =
        json['subject'] != null ? new Subject.fromJson(json['subject']) : null;
    if (json['course_view'] != null) {
      json['course_view'].forEach((v) {
        courseView.add(new CourseView.fromJson(v));
      });
    }
    if (json['rates'] != null) {
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
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

// class Materials {
//   int? courseId;
//   int? id;
//   String? name;
//   String? video;
//   var file;
//   var description;
//   String? price;
//
//
//
//   Materials.fromJson(Map<String, dynamic> json) {
//     courseId = json['course_id'];
//     id = json['id'];
//     name = json['name'];
//     video = json['video'];
//     file = json['file'];
//     description = json['description'];
//     price = json['price'];
//   }
//
// }

class Instructor {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
  }
}

class Comments {
  int? id;
  int? courseId;
  String? message;
  int? type;
  int? userId;

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    message = json['message'];
    type = json['type'];
    userId = json['user_id'];
  }
}

class Subject {
  int? id;
  String? name;
  int? levelId;
  bool? active;
  String? photo;

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    levelId = json['level_id'];
    active = json['active'];
    photo = json['photo'];
  }
}

class CourseView {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  var university;
  String? emailVerifiedAt;
  int? active;
  int? type;
  var verifyCode;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var googleId;
  var facebookId;
  Pivot? pivot;

  CourseView.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }
}

class Rates {
  int? id;
  var rate;
  int? courseId;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    courseId = json['course_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
