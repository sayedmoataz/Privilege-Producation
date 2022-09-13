// ignore_for_file: unnecessary_new, prefer_typing_uninitialized_variables, unused_import

import '/models/college_models/one_subject_college_model.dart';

class SearchModel {
  bool? status;
  int? code;
  String? msg;
  List<Data> data = [];

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  Level? level;
  Instructor? instructor;

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
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
  }
}

class Level {
  int? id;
  String? name;

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
