class BuyMaterialModel {
  bool? status;
  int? code;
  String? msg;
  String? data;

  BuyMaterialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }
}
