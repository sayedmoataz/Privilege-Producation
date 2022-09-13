// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class OneCollegesModel {
  OneCollegesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  int? code;
  Data? data;
  String? msg;
  bool? status;
}

class Data {
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    if (json['levels'] != null) {
      json['levels'].forEach((v) {
        levels.add(new Levels.fromJson(v));
      });
    }
  }

  int? id;
  List<Levels> levels = [];
  String? name;
  String? photo;
}

class Levels {
  Levels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    collegeId = json['college_id'];
    coursesCount = json['courses_count'];
  }

  int? collegeId;
  int? coursesCount;
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['college_id'] = this.collegeId;
    data['courses_count'] = this.coursesCount;
    return data;
  }
}
