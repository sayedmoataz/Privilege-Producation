// class OneSubjectModel {
//   bool? status;
//   int? code;
//   String? msg;
//   Data? data;
//
//   OneSubjectModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     code = json['code'];
//     msg = json['msg'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
// }
//
// class Data {
//   int? id;
//   String? name;
//   int? levelId;
//   bool? active;
//   String? photo;
//   var deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   int? term;
//   var type;
//   List<Courses> courses=[];
//
//
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     levelId = json['level_id'];
//     active = json['active'];
//     photo = json['photo'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     term = json['term'];
//     type = json['type'];
//     if (json['courses'] != null) {
//       json['courses'].forEach((v) {
//         courses.add(new Courses.fromJson(v));
//       });
//     }
//   }
//
// }
//
// class Courses {
//   int? id;
//   String? name;
//   String? photo;
//   int? price;
//   int? realPrice;
//   int? view;
//   int? rate;
//   String? description;
//   bool? active;
//   String ?createdAt;
//   Instructor? instructor;
//   List<CourseView> courseView=[];
//   List<Rates> rates=[];
//
//
//
//   Courses.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     photo = json['photo'];
//     price = json['price'];
//     realPrice = json['real_price'];
//     view = json['view'];
//     rate = json['rate'];
//     description = json['description'];
//     active = json['active'];
//     createdAt = json['created_at'];
//     instructor = json['instructor'] != null
//         ? new Instructor.fromJson(json['instructor'])
//         : null;
//     if (json['course_view'] != null) {
//       json['course_view'].forEach((v) {
//         courseView.add(new CourseView.fromJson(v));
//       });
//     }
//     if (json['rates'] != null) {
//       json['rates'].forEach((v) {
//         rates.add(new Rates.fromJson(v));
//       });
//     }
//   }
//
// }
//
// class Instructor {
//   int? id;
//   String? name;
//   String? photo;
//
//
//   Instructor.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     photo = json['photo'];
//   }
//
//
// }
//
// class CourseView {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? photo;
//   var university;
//   String? emailVerifiedAt;
//   bool? active;
//   int? type;
//   var verifyCode;
//   var deletedAt;
//   String? createdAt;
//   String? updatedAt;
//   var googleId;
//   var facebookId;
//   Pivot? pivot;
//
//
//   CourseView.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     photo = json['photo'];
//     university = json['university'];
//     emailVerifiedAt = json['email_verified_at'];
//     active = json['active'];
//     type = json['type'];
//     verifyCode = json['verify_code'];
//     deletedAt = json['deleted_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     googleId = json['google_id'];
//     facebookId = json['facebook_id'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//
// }
//
// class Pivot {
//   int? courseId;
//   int? userId;
//   String? createdAt;
//   String? updatedAt;
//
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     courseId = json['course_id'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
// }
//
// class Rates {
//   int? id;
//   int? rate;
//   int? courseId;
//   int? userId;
//   String? createdAt;
//   String? updatedAt;
//
//
//   Rates.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     rate = json['rate'];
//     courseId = json['course_id'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
// }
