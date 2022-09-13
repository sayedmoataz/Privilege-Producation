// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../search/search.dart';
import 'Notification_Screen.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var descriptionController = TextEditingController();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Directionality(
            textDirection:
                cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(cubit.isEnglish ? 'Contact Us' : 'تواصل معنا '),
                backgroundColor: HexColor('#0029e7'),
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
                actions: [
                  if (CacheHelper.getData(key: 'token') != null)
                    IconButton(
                        onPressed: () {
                          NavigateTo(context, Search());
                        },
                        icon: const Icon(Icons.search),
                        padding: const EdgeInsets.only(right: 10.0)),
                  if (CacheHelper.getData(key: 'token') != null)
                    IconButton(
                        onPressed: () {
                          NavigateTo(context, NotificationScreen());
                        },
                        icon: const Icon(Icons.notifications_active),
                        padding: const EdgeInsets.only(right: 10.0)),
                  /*TextButton(
                  onPressed: () {
                    cubit.changeLanguage();
                  },
                  child: Text(
                    cubit.isEnglish ? 'AR' : 'EN',
                    style: TextStyle(fontSize: 22, color: Colors.white)
                  )
                ),*/
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    if (CacheHelper.getData(key: 'token') == null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                                color: Colors.grey[300],
                                width: double.infinity,
                                child: MyTextFormField(
                                    context: context,
                                    controller: nameController,
                                    inputType: TextInputType.name,
                                    hint: cubit.isEnglish
                                        ? 'write your name'
                                        : 'أكتب اسمك')),
                            SizedBox(height: 15.0),
                            Container(
                                color: Colors.grey[300],
                                width: double.infinity,
                                child: MyTextFormField(
                                    context: context,
                                    controller: emailController,
                                    hint: cubit.isEnglish
                                        ? 'write your email ...'
                                        : "بريدك الإلكتروني",
                                    inputType: TextInputType.emailAddress)),
                          ],
                        ),
                      ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 200,
                            color: Colors.grey[300],
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: MyTextFormField(
                                    context: context,
                                    controller: descriptionController,
                                    hint: cubit.isEnglish
                                        ? 'write the message ...'
                                        : "رسالتك",
                                    border: InputBorder.none,
                                    length: 399,
                                    lines: 9)))),
                    SizedBox(height: 20),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(color: HexColor('#0029e7')),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                            onTap: () {
                              cubit
                                  .contactUs(
                                name: nameController.text.isEmpty
                                    ? CacheHelper.getData(key: 'name')
                                        .toString()
                                    : nameController.text.toString(),
                                email: emailController.text.isEmpty
                                    ? CacheHelper.getData(key: 'email')
                                        .toString()
                                    : emailController.text.toString(),
                                description: descriptionController.text,
                              )
                                  .then((value) {
                                if (cubit.contactUsModel!.status == true) {
                                  descriptionController.clear();
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? 'message has been sent successfully'
                                          : "تم الإرسال بنجاح");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? 'The given data was invalid'
                                          : " يوجد خطأ ببعض البيانات");
                                }
                              }).catchError((e) {
                                Fluttertoast.showToast(
                                    msg: cubit.contactUsModel!.msg.toString());
                              });
                            },
                            child: Text(
                              cubit.isEnglish ? 'send' : "إرسال",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
