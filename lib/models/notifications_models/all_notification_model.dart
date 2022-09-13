// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

class AllNotificationsModel {
  bool? status;
  int? code;
  String? msg;
  List<Data> data = [];

  AllNotificationsModel.fromJson(Map<String, dynamic> json) {
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
  String? message;
  var courseId;
  int? isForAll;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  var course;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    courseId = json['course_id'];
    isForAll = json['is_for_all'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course = json['course'];
  }
}
