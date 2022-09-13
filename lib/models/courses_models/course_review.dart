class CourseReviewModel {
  bool? status;
  int? code;
  String? msg;

  CourseReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
