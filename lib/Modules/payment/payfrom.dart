// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, must_be_immutable, unnecessary_new, unused_element, avoid_print, unused_import

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:privilege/Modules/Home_Pages/home_page.dart';
import 'package:privilege/Modules/content_modules/one_course_screen.dart';
import 'package:privilege/Shared/UI/components.dart';
import 'package:url_launcher/url_launcher.dart';

import '/Modules/payment/buy_web_view.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/local/cache_helper.dart';
import '../Menu_Screens/Notification_Screen.dart';
import '../search/search.dart';

class PayFrom extends StatelessWidget {
  final bool isCourse;
  final String? materialId;
  final String? materialName;
  final String phoneNumber;

  const PayFrom(
  {Key? key,
  required this.isCourse,
  this.materialId,
  required,
  this.materialName,
  required this.phoneNumber})
: super(key: key);

void whatsAppOpen(messagedesc) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/+2$phoneNumber/?text=${Uri.encodeFull(messagedesc)}";
    } else {
      return "whatsapp://send?phone=+2$phoneNumber&text=${Uri.encodeFull(messagedesc)}";
    }
  }
}


@override
Widget build(BuildContext context) {
  var email = CacheHelper.getData(key: 'email');
  return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection:
          cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: myappbar(
                context: context,
                title: cubit.isEnglish ? 'Payment' : 'الدفع / الشراء'),
            drawer: CustomDrawer(isEnglish: cubit.isEnglish),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/undraw_Payments_re_77x0.png'),
                        if (Platform.isAndroid)
                          TextButton(
                            onPressed: () async {
                              if (isCourse) {
                                whatsAppOpen(
                                    'Hi please I want to buy ur Course : ${cubit.oneCourseModel!.data!.name.toString()} \nwith ID : ${cubit.oneCourseModel!.data!.id.toString()} \nMy Account is : $email');
                              } else {
                                if (materialId != null) {
                                  whatsAppOpen(
                                      'Hi please I want to buy ur material : $materialName  with ID  : $materialId \nMy Account is : $email');
                                }
                              }
                            },
                            child: Text(
                              cubit.isEnglish
                                  ? 'Buy Using Whatsapp'
                                  : 'اشترى بواسطة واتساب',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        SizedBox(height: 15),
                        TextButton(
                          onPressed: () async {
                            if (isCourse) {
                              await cubit
                                  .buyCourse(
                                  cubit.oneCourseModel!.data!.id.toString())
                                  .then((value) {
                                print(
                                    "Course ID IS : ${cubit.oneCourseModel!.data!.id.toString()}");
                                print(
                                    "Course Name IS : ${cubit.oneCourseModel!.data!.name.toString()}");
                                _launchUrl(
                                    cubit.buyCourseModel!.data.toString())
                                    .then((value) {
                                  print(
                                      "Link is : ${cubit.buyCourseModel!.data.toString()}");
                                  cubit.getUserArray();
                                  cubit.getUserCourses();
                                  cubit
                                      .getOneCourse(cubit
                                      .oneCourseModel!.data!.id
                                      .toString())
                                      .then((value) {
                                    navigateFinalTo(context, HomePage());
                                  });
                                });
                              });
                            } else {
                              cubit.updatingCourseFev(true);
                              await cubit
                                  .buyMaterial(materialId.toString())
                                  .then((value) {
                                print(
                                    "Material Id Is : ${materialId.toString()}");
                                print(
                                    "Material name Is : ${materialName.toString()}");
                                _launchUrl(
                                    cubit.buyMaterialModel!.data.toString())
                                    .then((value) {
                                  print(
                                      " Link is : ${cubit.buyMaterialModel!.data.toString()}");
                                  cubit.getUserArray();
                                  cubit
                                      .getOneCourse(cubit
                                      .oneCourseModel!.data!.id
                                      .toString())
                                      .then((value) {
                                    cubit.updatingCourseFev(false);
                                  });
                                }).catchError((e) {
                                  print("_launchUrl error is : $e");
                                });
                                cubit.updatingCourseFev(false);
                              }).catchError((e) {
                                print("buyMaterial error is : $e");
                              });
                            }
                          },
                          child: Text(
                            cubit.isEnglish
                                ? 'Buy Using Credit Card'
                                : 'اشترى ببطاقة الائتمان',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      });
}
}

_launchUrl(String _url) async {
  if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
}
