class ContactUsModel {
  bool? status;
  int? code;
  String? msg;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
