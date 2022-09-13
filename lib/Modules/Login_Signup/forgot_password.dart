// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/Login_Signup/login_screen.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: Text(
                    cubit.isEnglish ? 'forget password' : 'نسيت كلمة السر'),
                backgroundColor: HexColor('#0029e7'),
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      cubit.isEnglish
                          ? 'We will send a password to your email you can login with it and change it later'
                          : 'سنقوم بإرسال كلمة سر جديدة الي بريدك الإلكتروني الذي سجلت به',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            color: Colors.grey[300],
                            width: double.infinity,
                            child: MyTextFormField(
                              context: context,
                              controller: emailController,
                              inputType: TextInputType.emailAddress,
                              hint: cubit.isEnglish
                                  ? 'write your email'
                                  : 'البريد الإلكتروني',
                              border: InputBorder.none,
                            ))),
                    SizedBox(height: 50),
                    cubit.isLoadingAuth
                        ? Center(
                            child: CircularProgressIndicator(
                            color: HexColor('#0029e7'),
                          ))
                        : MaterialButton(
                            child: Text(cubit.isEnglish
                                ? 'Get New Password'
                                : 'الحصول علي كلمة سر جديدة'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: HexColor('#0029e7'),
                            height: 50,
                            minWidth: 130,
                            onPressed: () async {
                              cubit.loadingAuthScreens(true);
                              await cubit
                                  .resetPassword(emailController.text)
                                  .then((value) {
                                if (cubit.resetPasswordModel!.code == 201) {
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? '${cubit.resetPasswordModel!.msg} please check your email'
                                          : '${cubit.resetPasswordModel!.msg} راجع بريدك الإلكتروني');
                                  cubit.loadingAuthScreens(false);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      (MaterialPageRoute(
                                          builder: (context) => LoginScreen())),
                                      (route) => false);
                                } else {
                                  cubit.loadingAuthScreens(false);
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? 'Invalid email address'
                                          : 'بريد إلكتروني غير صالح');
                                }
                              }).catchError((e) {
                                cubit.loadingAuthScreens(false);
                                Fluttertoast.showToast(
                                    msg: cubit.isEnglish
                                        ? 'Invalid email address'
                                        : 'بريد إلكتروني غير صالح');
                              });
                            })
                  ],
                ),
              ),
            ),
          );
        });
  }
}
