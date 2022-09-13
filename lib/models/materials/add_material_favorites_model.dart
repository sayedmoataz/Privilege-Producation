class AddMaterialFavoriteModel {
  bool? status;
  int? code;
  String? msg;

  AddMaterialFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
