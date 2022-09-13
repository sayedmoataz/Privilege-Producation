// ignore_for_file:  prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unused_local_variable, unused_field, prefer_const_declarations, prefer_final_fields, non_constant_identifier_names, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:privilege/Modules/Login_Signup/verification.dart';
import 'package:privilege/Shared/UI/components.dart';
import 'package:sqflite/sqflite.dart';

import '/Shared/local/cache_helper.dart';
import '/cubit/states.dart';
import '/models/auth_models/login_model.dart';
import '/models/auth_models/register_model.dart';
import '/models/auth_models/verify_email_model.dart';
import '/models/college_models/all_colleges_model.dart';
import '/models/college_models/one_college_model.dart';
import '/models/contact_us/about_us_model.dart';
import '/models/contact_us/contact_us_model.dart';
import '/models/courses_models/add_course_fav.dart';
import '/models/courses_models/buy_course_model.dart';
import '/models/courses_models/one_course.dart';
import '/models/courses_models/one_user_course.dart';
import '/models/courses_models/store_messege.dart';
import '/models/courses_models/user_courses_model.dart';
import '/models/instructor/instructor_model.dart';
import '/models/levels_models/one_level_model.dart';
import '/models/materials/all_materials.dart';
import '/models/materials/buy_material.dart';
import '/models/materials/delete_material_favorites.dart';
import '/models/materials/favorite_materials_model.dart';
import '/models/materials/one_material_model.dart';
import '/models/notifications_models/all_notification_model.dart';
import '/models/search_models/search_model.dart';
import '/models/universities_models/all_universities.dart';
import '/models/universities_models/one_university_model.dart';
import '/models/user_models/array_model.dart';
import '/models/user_models/profile_model.dart';
import '/models/user_models/reset_password_model.dart';
import '../models/courses_models/course_review.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitState());

  static HomeCubit get(contaxt) => BlocProvider.of(contaxt);
  String APIsURL = 'https://www.privilegeapps.com/api';
  double rate = 0;
  bool isCodeEditing = true;
  bool isCourseBought = false;
  bool isLoadingAuth = false;
  bool isLoginPassword = true;
  bool isRegisterPassword = true;
  bool isRegisterPassword2 = true;
  bool isUpdatingCourseFev = false;
  bool isEnglish = true;
  bool isCourseRated = false;
  bool _value = false;
  int val = -1;
  var searchController = TextEditingController();
  var errorRegister;
  late String verificationCode;
  static ProfileModel? profileModel;
  AboutUsModel? aboutUsModel;
  AddCourseFavModel? addCourseFavModel;
  AllCollegesModel? allCollegesModel;
  AllMaterialsModel? allMaterialsModel;
  AllNotificationsModel? allNotificationsModel;
  AllUniversitiesModel? allUniversitiesModel;
  BuyCourseModel? buyCourseModel;
  BuyMaterialModel? buyMaterialModel;
  ContactUsModel? contactUsModel;
  DeleteMaterialFavoriteModel? deleteFavoriteModel;
  FavouriteCoursesModel? favoritesModel;
  InstructorModel? instructorModel;
  LoginModel? loginModel;
  OneCollegesModel? oneCollegesModel;
  OneCourseModel? oneCourseModel;
  OneLevelModel? oneLevelModel;
  OneMaterialModel? oneMaterialModel;
  OneUniversityModel? oneUniversityModel;
  OneUserCourseModel? oneUserCourseModel;
  RegisterModel? registerModel;
  ResetPasswordModel? resetPasswordModel;
  SearchModel? searchModel;
  StoreMessageModel? storeMessageModel;
  UserArrayModel? userArrayModel;
  UserCoursesModel? userCoursesModel;
  VerifyEmailModel? verifyEmailModel;

  void changeLanguage() {
    isEnglish = !isEnglish;
    emit(HomeChangeLanguageState());
    CacheHelper.putData(key: 'isEnglish', value: isEnglish);
    emit(HomeChangeLanguageState());
  }

  void changeLanguageSelect(value) {
    val = value;
    emit(HomechangeLanguageSelectState());
  }

  void checkCourseBought(bool value) {
    isCourseBought = value;
    emit(HomeIsCourseBoughtState());
  }

  void updatingCourseFev(bool value) {
    isUpdatingCourseFev = value;
    emit(HomeIsCourseFevState());
  }

  void loadingAuthScreens(bool value) {
    isLoadingAuth = value;
    emit(HomeLoadingAutScreensState());
  }

  void changeLoginPasswordVisibility() {
    isLoginPassword = !isLoginPassword;
    emit(HomeIsPasswordState());
  }

  void changeRegisterPasswordVisibility() {
    isRegisterPassword = !isRegisterPassword;
    emit(HomeIsPasswordState());
  }

  void changeRegisterPasswordVisibility2() {
    isRegisterPassword2 = !isRegisterPassword2;
    emit(HomeReIsPasswordState());
  }

  void onVerCodeEditing(bool value) {
    isCodeEditing = value;
    emit(HomIsEditingVerCodeState());
  }

  void onVerCodeComplete(String value) {
    verificationCode = value;
    emit(HomIsCompleteVerCodeState());
  }

  void checkCourseRated(bool value) {
    isCourseRated = value;
    emit(HomeIsCourseRatedState());
  }

  void onRateChanged(double value) {
    rate = value;
    emit(HomeRatingUpdateState());
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> resetPassword(String email) async {
    var data = {'email': email};
    var uri = Uri.parse('${APIsURL}/password/reset');
    emit(HomeResetPasswordLoadingState());
    await http
        .post(uri, headers: {"Accept": "application/json"}, body: data)
        .then((value) {
      resetPasswordModel = ResetPasswordModel.fromJson(jsonDecode(value.body));
      //print(value.body);
      emit(HomeResetPasswordSuccessState());
    }).catchError((e) {
      emit(HomeResetPasswordErrorState());
    });
  }

  Future<void> getAllUniversities() async {
    isEnglish = CacheHelper.getData(key: 'isEnglish') ?? true;
    emit(HomeGetAllUniversitiesLoadingState());
    var uri = Uri.parse('${APIsURL}/university');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      allUniversitiesModel =
          AllUniversitiesModel.fromJson(jsonDecode(value.body));
      emit(HomeGetAllUniversitiesSuccessState());
    }).catchError((e) {
      emit(HomeGetAllUniversitiesErrorState());
    });
  }

  Future<void> getOneUniversity(String universityId) async {
    emit(HomeGetOneUniversityLoadingState());
    var uri = Uri.parse('${APIsURL}/university/$universityId');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      oneUniversityModel = OneUniversityModel.fromJson(jsonDecode(value.body));
      emit(HomeGetOneUniversitySuccessState());
    }).catchError((e) {
      emit(HomeGetOneUniversityErrorState());
    });
  }

  Future<void> getAllColleges() async {
    emit(HomeGetAllCollagesLoadingState());
    var uri = Uri.parse('${APIsURL}/college');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      allCollegesModel = AllCollegesModel.fromJson(jsonDecode(value.body));
      emit(HomeGetAllCollagesSuccessState());
    }).catchError((e) {
      emit(HomeGetAllCollagesErrorState());
    });
  }

  Future<void> getOneCollege(String collegeId) async {
    oneCollegesModel = null;
    emit(HomeGetOneCollegeLoadingState());
    var uri = Uri.parse('${APIsURL}/college/$collegeId');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      oneCollegesModel = OneCollegesModel.fromJson(jsonDecode(value.body));
      emit(HomeGetOneCollegeSuccessState());
    }).catchError((e) {
      emit(HomeGetOneCollegeErrorState());
    });
  }

  Future<void> getInstructorData(String id) async {
    emit(HomeGetInstructorDataLoadingState());
    var uri = Uri.parse('${APIsURL}/instructor/$id');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      instructorModel = InstructorModel.fromJson(jsonDecode(value.body));
      emit(HomeGetInstructorDataSuccessState());
    }).catchError((e) {
      emit(HomeGetInstructorDataErrorState());
    });
  }

  Future<void> getProfileData() async {
    emit(HomeGetProfileLoadingState());
    var uri = Uri.parse('${APIsURL}/profile');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      //print(value.body.toString());
      profileModel = ProfileModel.fromJson(jsonDecode(value.body));
      emit(HomeGetProfileSuccessState());
    }).catchError((e) {
      emit(HomeProfileErrorState());
    });
  }

  Future<void> uploadProfileImages(image) async {}

  Future<void> getAllNotifications() async {
    emit(HomeGetAllNotificationsLoadingState());
    var uri = Uri.parse('${APIsURL}/notification');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      allNotificationsModel =
          AllNotificationsModel.fromJson(jsonDecode(value.body));
      emit(HomeGetAllNotificationsSuccessState());
    }).catchError((e) {
      emit(HomeGetAllNotificationsErrorState());
    });
  }

  Future<void> buyCourse(String courseId) async {
    var data = {'course_id': courseId};
    var uri = Uri.parse('${APIsURL}/payment');
    emit(HomeBuyCourseLoadingState());
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      buyCourseModel = BuyCourseModel.fromJson(jsonDecode(value.body));
      print("value is : ${value.body}");
      print("buyCourseModel is : $buyCourseModel");
      emit(HomeBuyCourseSuccessState());
    }).catchError((e) {
      emit(HomeBuyCourseErrorState());
    });
  }

  Future<void> storeMessage(String courseId, String message) async {
    var data = {'course_id': courseId, 'message': message};
    var uri = Uri.parse('${APIsURL}/chat');
    emit(HomeCourseStoreMessageLoadingState());
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      storeMessageModel = StoreMessageModel.fromJson(jsonDecode(value.body));
      emit(HomeCourseStoreMessageSuccessState());
    }).catchError((e) {
      emit(HomeCourseStoreMessageErrorState());
    });
  }

  Future<void> getOneCourse(String courseId) async {
    var uri = Uri.parse('${APIsURL}/course/$courseId');
    oneCourseModel = null;
    emit(HomeOneCourseMessageLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      oneCourseModel = OneCourseModel.fromJson(jsonDecode(value.body));
      emit(HomeOneCourseMessageSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(HomeOneCourseMessageErrorState());
    });
  }

  Future<void> getOneUserCourse(String courseId) async {
    var uri = Uri.parse('${APIsURL}/my-courses/$courseId');
    emit(HomeGetOneUserCoursesLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      oneUserCourseModel = OneUserCourseModel.fromJson(jsonDecode(value.body));
      emit(HomeGetOneUserCoursesSuccessState());
    }).catchError((e) {
      emit(HomeGetOneUserCoursesErrorState());
    });
  }

  Future<void> getUserCourses() async {
    var uri = Uri.parse('${APIsURL}/my-courses');
    emit(HomeGetUserCoursesLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      userCoursesModel = UserCoursesModel.fromJson(jsonDecode(value.body));
      emit(HomeGetUserCoursesSuccessState());
    }).catchError((e) {
      emit(HomeGetUserCoursesErrorState());
    });
  }

  Future<void> getAllMaterials() async {
    var uri = Uri.parse('${APIsURL}/material');
    emit(HomeAllMaterialsLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      allMaterialsModel = AllMaterialsModel.fromJson(jsonDecode(value.body));
      emit(HomeAllMaterialsSuccessState());
    }).catchError((e) {
      emit(HomeAllMaterialsErrorState());
    });
  }

  Future<void> getFavoritesCourses() async {
    var uri = Uri.parse('${APIsURL}/favorite-course');
    emit(HomeAllMaterialsLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      favoritesModel = FavouriteCoursesModel.fromJson(jsonDecode(value.body));
      emit(HomeAllMaterialsSuccessState());
    }).catchError((e) {
      emit(HomeAllMaterialsErrorState());
    });
  }

  Future<void> getOneMaterial(String materialId) async {
    var uri = Uri.parse('${APIsURL}/material/$materialId');
    emit(HomeGetOneMaterialLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      oneMaterialModel = OneMaterialModel.fromJson(jsonDecode(value.body));
      print(" getOneMaterial body is : ${value.body}");
      emit(HomeGetOneMaterialSuccessState());
    }).catchError((e) {
      emit(HomeGetOneMaterialErrorState());
    });
  }

  Future<void> buyMaterial(String materialId) async {
    var data = {'material_id': materialId};
    var uri = Uri.parse('${APIsURL}/material/buy');
    emit(HomeBuyMaterialLoadingState());
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      buyMaterialModel = BuyMaterialModel.fromJson(jsonDecode(value.body));
      print("value is ${value.body}");
      print("buyMaterialModel is $buyMaterialModel");
      emit(HomeBuyMaterialSuccessState());
    }).catchError((e) {
      emit(HomeBuyMaterialErrorState());
    });
  }

  Future<void> addCourseFavorite(String materialId) async {
    var data = {'course_id': materialId};
    var uri = Uri.parse('${APIsURL}/favorite-course');
    emit(HomeAddMaterialFavoritesLoadingState());
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      addCourseFavModel = AddCourseFavModel.fromJson(jsonDecode(value.body));
      emit(HomeAddMaterialFavoritesSuccessState());
    }).catchError((e) {
      emit(HomeAddMaterialFavoritesErrorState());
    });
  }

  Future<void> deleteCourseFavorite(String id) async {
    favoritesModel = null;
    var uri = Uri.parse('${APIsURL}/favorite-course/$id');
    emit(HomeDeleteMaterialFavoritesLoadingState());
    await http.delete(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      deleteFavoriteModel =
          DeleteMaterialFavoriteModel.fromJson(jsonDecode(value.body));
      emit(HomeDeleteMaterialFavoritesSuccessState());
    }).catchError((e) {
      emit(HomeDeleteMaterialFavoritesErrorState());
    });
  }

  Future<void> getOneLevel(String levelId) async {
    var uri = Uri.parse('${APIsURL}/level/$levelId');
    emit(HomeGetOneLevelsLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      oneLevelModel = OneLevelModel.fromJson(jsonDecode(value.body));
      if (kDebugMode) {
        print(oneLevelModel!.data!.courses[0].name);
      }
      emit(HomeGetOneLevelsSuccessState());
    }).catchError((e) {
      emit(HomeGetOneLevelsErrorState());
    });
  }

  Future<void> getUserArray() async {
    var uri = Uri.parse('${APIsURL}/array');
    emit(HomeGetUserArrayLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      userArrayModel = UserArrayModel.fromJson(jsonDecode(value.body));
      emit(HomeGetUserArraySuccessState());
    }).catchError((e) {
      emit(HomeGetUserArrayErrorState());
    });
  }

  Future<void> aboutUs() async {
    emit(HomeAboutUsLoadingState());
    var uri = Uri.parse('${APIsURL}/about_us');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      aboutUsModel = AboutUsModel.fromJson(jsonDecode(value.body));
      emit(HomeAboutUsSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(HomeAboutUsErrorState());
    });
  }

  Future<void> search(String text) async {
    Map<String, dynamic> queryParameters = {'search': text};
    var uri = Uri.https('137.184.24.42', '/api/search2', queryParameters);
    emit(HomeSearchLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      searchModel = SearchModel.fromJson(jsonDecode(value.body));
      emit(HomeSearchSuccessState());
    }).catchError((e) {
      emit(HomeSearchErrorState());
    });
  }

  Future<void> SendApplePayDetails(String Course_id, String Material_id,
      String Price, BuildContext context) async {
    if (kDebugMode) {
      print("payyyyyyyyy");
    }
    Map<String, dynamic> queryParameters = {
      'course_id': Course_id,
      'material_id': Material_id,
      'price': Price
    };
    var uri = Uri.https('privilegeapps.com', '/api/apple/pay', queryParameters);
    emit(HomeSendApplePayDetailsLoadingState());
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (kDebugMode) {
        print(value.body);
      }
      //searchModel = SearchModel.fromJson(jsonDecode(value.body));
      emit(HomeSendApplePayDetailsSuccessState());
      Fluttertoast.showToast(msg: 'Success pay', textColor: Colors.green);
    }).catchError((e) {
      emit(HomeSendApplePayDetailsErrorState());
      Fluttertoast.showToast(msg: 'Error pay $e', textColor: Colors.red);
    });
  }

  Future<void> verifyEmail() async {
    emit(HomeVerifyEmailLoadingState());
    var loginData = {
      'email': CacheHelper.getData(key: 'email'),
      'code': verificationCode
    };
    await http
        .post(Uri.parse('$APIsURL/email/verify'), body: loginData, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      'Accept': 'application/json'
    }).then((value) {
      verifyEmailModel = VerifyEmailModel.fromJson(jsonDecode(value.body));
      emit(HomeVerifyEmailSuccessState());
    }).catchError((e) {
      emit(HomeVerifyEmailErrorState());
    });
  }

  Future<void> contactUs(
      {required String description,
      required String email,
      required String name}) async {
    emit(HomeVerifyEmailLoadingState());

    var userData = {
      'name': CacheHelper.getData(key: 'token') == null
          ? name
          : profileModel!.data!.name,
      'email': CacheHelper.getData(key: 'token') == null
          ? email
          : profileModel!.data!.email,
      'description': description,
    };
    await http
        .post(Uri.parse('${APIsURL}/contact-us'), body: userData, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      'Accept': 'application/json'
    }).then((value) {
      //print("=====================================");
      //print(value.body.toString());
      //print("=====================================");
      contactUsModel = ContactUsModel.fromJson(jsonDecode(value.body));
      //print(contactUsModel!.msg.toString());
      emit(HomeVerifyEmailSuccessState());
    }).catchError((e) {
      //print(e.toString());
      emit(HomeVerifyEmailErrorState());
    });
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      String? university,
      required BuildContext context
      // String? image,
      }) async {
    var DeviceToken = await FirebaseMessaging.instance.getToken();
    var formData = {
      "email": email,
      "password": password,
      "name": name,
      "phone": phone,
      "university": university,
      "device_token": DeviceToken,
      // image!=null? "photo": '':'',
    };
    emit(HomeRegisterLoadingState());
    var uri = Uri.parse('$APIsURL/student');
    await http.post(uri,
        body: formData, headers: {"Accept": "application/json"}).then((value) {
      if (jsonDecode(value.body)['message'] == 'The given data was invalid.') {
        Fluttertoast.showToast(msg: jsonDecode(value.body)['message']);
        loadingAuthScreens(false);
      } else {
        registerModel = RegisterModel.fromJson(jsonDecode(value.body));
        CacheHelper.putData(key: 'email', value: registerModel!.data!.email)
            .then((value) {
          loadingAuthScreens(false);
          NavigateTo(context, const Verification());
        });
      }
      emit(HomeRegisterSuccessState());
    }).catchError((e) {
      emit(HomeRegisterErrorState());
    });
  }

  Future<void> login(
      {required String email,
      String? password,
      String? phone,
      String? name}) async {
    emit(HomeLoginLoadingState());
    var DeviceToken = await FirebaseMessaging.instance.getToken();
    await http.post(Uri.parse('${APIsURL}/login'),
        body: CacheHelper.getData(key: 'socialToken') == null
            ? {
                'email': email,
                'password': password,
                "device_token": DeviceToken
              }
            : {
                'email': email,
                'name': name,
                'phone': phone,
                'social_id': CacheHelper.getData(key: 'socialToken')
              },
        headers: {'Accept': 'application/json'}).then((value) {
      loginModel = LoginModel.fromJson(jsonDecode(value.body));
      emit(HomeLoginSuccessState());
    }).catchError((e) {
      emit(HomeLoginErrorState());
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    emit(HomeDeleteAccountLoadingState());
    var uri = Uri.parse('${APIsURL}/delete/student');
    await http.post(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      if (jsonDecode(value.body)['status'] == true) {
        Fluttertoast.showToast(msg: jsonDecode(value.body)['msg']);
        CacheHelper.deleteData(key: 'token');
        CacheHelper.deleteData(key: 'email');
        Navigator.pop(context);
        Navigator.pop(context);
      }
      emit(HomeDeleteAccountSuccessState());
    }).catchError((e) {
      emit(HomeDeleteAccountErrorState());
    });
  }

  Future<void> editProfile(
      String email,
      String password,
      String phone,
      String university,
      String image,
      String name,
      BuildContext context) async {
    var data = {
      'email': email,
      'password': password,
      'phone': phone,
      (image == '') ? '' : 'photo': image,
      'name': name,
      'university': university
    };
    emit(HomeEditProfileLoadingState());
    await http
        .post(Uri.parse('${APIsURL}/student/update'), body: data, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      if (jsonDecode(value.body)['code'] == 200) {
        profileModel = ProfileModel.fromJson(jsonDecode(value.body));
        Fluttertoast.showToast(msg: 'updated successfully');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Invalid input data');
      }
      emit(HomeEditProfileSuccessState());
    }).catchError((e) {
      emit(HomeEditProfileErrorState());
    });
  }

  /*
  Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

  Future<void> SignOut() async {
  await FirebaseAuth.instance.signOut();
}
*/

  // course review
  CourseReviewModel? courseReviewModel;

  Future<void> courseReview(String courseId, String rate) async {
    var data = {'course_id': courseId, 'rate': rate};
    var uri = Uri.parse('${APIsURL}/rate/course');
    emit(HomeCourseReviewLoadingState());
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      courseReviewModel = CourseReviewModel.fromJson(jsonDecode(value.body));
      if (kDebugMode) {
        print(value.body);
      }
      emit(HomeCourseReviewSuccessState());
    }).catchError((e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(HomeCourseReviewErrorState());
    });
  }

/*
  var responseBodyDeviceToken;

  Future sendDeviceToken() async {
    var DeviceToken = await FirebaseMessaging.instance.getToken();

    emit(HomeSendDeviceTokenLoadingState());
    var uri = Uri.parse('${APIsURL}/saveDeviceToken');
    await http
        .post(uri, headers: {'Authorization': 'Bearer $DeviceToken()'}).then(
            (value) async {
      if (jsonDecode(value.body).toString() == "success") {
        responseBodyDeviceToken = jsonDecode(value.body);
      }
      emit(HomeSendDeviceTokenSuccessState());
    }).catchError((error) {
      emit(HomeSendDeviceTokenErrorState());
    });
  }
*/

  late Database database;
  DateTime selectedDay = DateTime.now();
  DateTime foucsedDay = DateTime.now();

  void selectDay(sday, fday) {
    selectedDay = sday;
    foucsedDay = fday;
    emit(SelectDayState());
  }

  createDataBase() async {
    //openDatabase(path,on create ,on open ) function that within it , we create db and create table an open db
    await openDatabase('Calendar.db', version: 1, onCreate: (db, version) {
      print(
          'Database is created and given me object of it is called db and version $version ');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT)')
          .then((value) => print('table is created'))
          .catchError((onError) {
        print('error is ${onError.toString()}');
      }); //create table
    }, onOpen: (db) {
      getDataFromDataBase(db);
      print('db is opened');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertToDatabase({required String title, required String date}) {
    database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date) VALUES("$title", "$date")');
    }).then((value) {
      print('data inserted $value ');
      emit(InsertDataBaseState());
      getDataFromDataBase(database);
    });
  }

  List<dynamic> mytasks = [];

  getDataFromDataBase(Database database) async {
    mytasks.clear();
    await database.rawQuery("SELECT * FROM tasks").then((value) {
      value.forEach((element) {
        mytasks.add(element);
      });
      emit(GetFromDataBaseState());
    });
  }

  delete() async {
    await deleteDatabase('Calendar.db').then((value) => print('deleted'));
  }

  deleteRow({required int id}) async {
    // Update some record
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteDataBaseState());
      getDataFromDataBase(database);
    });
  }
}
