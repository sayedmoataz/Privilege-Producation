class RegisterModel {
  late String token;
  late String message;
  late UserLoginData? data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? UserLoginData.fromJson(json['data']) : null;
  }
}

class UserLoginData {
  int? id;
  int? type;
  String? name;
  String? email;
  String? phone;
  String? university;
  String? createdAt;
  String? updatedAt;

  UserLoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    university = json['university'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
