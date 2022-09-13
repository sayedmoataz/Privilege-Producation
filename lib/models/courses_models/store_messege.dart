class StoreMessageModel {
  bool? status;
  int? code;
  String? msg;

  StoreMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
