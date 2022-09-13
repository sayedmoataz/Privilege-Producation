// ignore_for_file: unnecessary_new, unnecessary_this, prefer_collection_literals, prefer_typing_uninitialized_variables

class FavouriteCoursesModel {
  bool? status;
  int? code;
  String? msg;
  List<Data> data = [];

  FavouriteCoursesModel.fromJson(Map<String, dynamic> json) {
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

  //var rate;
  String? description;
  int? term;
  int? type;
  int? active;
  String? createdAt;
  Pivot? pivot;

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
  }
}

class Pivot {
  int? userId;
  int? courseId;

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    return data;
  }
}
