class AllUniversitiesModel {
  bool? status;
  int? code;
  String? msg;
  List<AllUniversitiesItems> data = [];
  bool? check;

  AllUniversitiesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    json['data'].forEach((element) {
      data.add(AllUniversitiesItems.fromJson(element));
    });
    check = json["check"];
  }
}

class AllUniversitiesItems {
  int? id;
  String? name;
  String? photo;
  int? collegesCount;

  AllUniversitiesItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    collegesCount = json['colleges_count'];
  }
}
