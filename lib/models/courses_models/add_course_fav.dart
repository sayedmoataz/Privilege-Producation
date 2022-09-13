class AddCourseFavModel {
  bool? status;
  int? code;
  String? msg;

  AddCourseFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
