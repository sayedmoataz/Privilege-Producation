// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

class OneCourseModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  OneCourseModel.fromJson(Map<String, dynamic> json) {
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
  int? term;
  int? type;
  int? active;
  String? createdAt;
  int? commentsCount;
  int? isMyRate;
  int? isMyCourse;

  // List<int> myMaterial = [];
  List<Materials> materials = [];
  Instructor? instructor;
  Level? level;

  Data.fromJson(Map<String, dynamic> json) {
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
    commentsCount = json['comments_count'];
    isMyRate = json['is_my_rate'];
    isMyCourse = json['is_my_course'];
    //myMaterial = json['my_material'].cast<int>();
    if (json['materials'] != null) {
      json['materials'].forEach((v) {
        materials.add(new Materials.fromJson(v));
      });
    }
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
  }
}

class Materials {
  int? courseId;
  int? id;
  int? viewNumber;
  String? name;
  var description;
  String? price;

  Materials.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    id = json['id'];
    viewNumber = json['view_number'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
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
