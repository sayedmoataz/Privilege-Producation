class DeleteMaterialFavoriteModel {
  bool? status;
  int? code;
  String? msg;

  DeleteMaterialFavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
  }
}
