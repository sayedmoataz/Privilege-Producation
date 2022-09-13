// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

class OneMaterialModel {
  bool? status;
  int? code;
  String? msg;
  DataOneMaterial? data;

  OneMaterialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null
        ? new DataOneMaterial.fromJson(json['data'])
        : null;
  }
}

class DataOneMaterial {
  int? id;
  String? name;
  String? video;
  var file;
  var description;
  String? price;
  int? active;
  int? courseId;
  var deletedAt;
  String? createdAt;
  String? updatedAt;
  int? viewNumber;

  DataOneMaterial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    video = json['video'];
    file = json['file'];
    description = json['description'];
    price = json['price'];
    active = json['active'];
    courseId = json['course_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    viewNumber = json['view_number'];
  }
}
