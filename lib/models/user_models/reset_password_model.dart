class ResetPasswordModel {
  bool? status;
  int? code;
  String? msg;

  ResetPasswordModel({this.status, this.code, this.msg});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
