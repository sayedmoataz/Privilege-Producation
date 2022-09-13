// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, unused_import, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_field.dart';

import '/Modules/Login_Signup/login_screen.dart';
import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/auth_models/verify_email_model.dart';
import '../Home_Pages/home_page.dart';

class Verification extends StatelessWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                      child: Image.asset(
                    'assets/3.png',
                    scale: 6,
                  )
                      /*Column(
                      children: [
                        Text("Privilege",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "Login To Your Account",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),*/
                      ),
                  Text('Please Check Your Email Address',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#0029e7'))),
                  Text('yo\'ve recicve 6 digits OTP Code',
                      style:
                          TextStyle(fontSize: 18, color: HexColor('#616363'))),
                  VerificationCode(
                    textStyle:
                        TextStyle(fontSize: 20.0, color: HexColor('#dd2634')),
                    keyboardType: TextInputType.number,
                    underlineColor: HexColor('#f6d246'),
                    length: 6,
                    cursorColor: HexColor('#0029e7'),
                    onCompleted: (String value) {
                      cubit.onVerCodeComplete(value);
                    },
                    onEditing: (bool value) {
                      cubit.onVerCodeEditing(value);
                      if (cubit.isCodeEditing) FocusScope.of(context).unfocus();
                    },
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    child: cubit.isLoadingAuth
                        ? Center(
                            child: CircularProgressIndicator(
                              color: HexColor('#0029e7'),
                            ),
                          )
                        : MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            color: HexColor('#0029e7'),
                            onPressed: () async {
                              cubit.loadingAuthScreens(true);
                              await cubit.verifyEmail().then((value) async {
                                CacheHelper.putData(
                                        key: 'email',
                                        value:
                                            cubit.verifyEmailModel!.data!.email)
                                    .then((value) {
                                  if (value) {
                                    CacheHelper.putData(
                                            key: 'uid',
                                            value: cubit
                                                .verifyEmailModel!.data!.id)
                                        .then((value) => {
                                              if (value)
                                                {
                                                  CacheHelper.putData(
                                                          key: 'token',
                                                          value: cubit
                                                              .verifyEmailModel!
                                                              .data!
                                                              .token)
                                                      .then((value) async {
                                                    if (cubit.verifyEmailModel!
                                                            .code ==
                                                        200) {
                                                      await cubit
                                                          .getAllUniversities();
                                                      await cubit
                                                          .getFavoritesCourses();
                                                      await cubit
                                                          .getProfileData();
                                                      await cubit
                                                          .getUserArray();
                                                      await cubit
                                                          .getUserCourses();
                                                      await cubit
                                                          .getAllNotifications();
                                                      await cubit.aboutUs();
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      HomePage()),
                                                          (route) => false);
                                                      cubit.loadingAuthScreens(
                                                          false);
                                                    }
                                                  })
                                                }
                                            });
                                  }
                                });
                              }).catchError((e) {
                                cubit.loadingAuthScreens(false);
                                Fluttertoast.showToast(
                                    msg:
                                        cubit.verifyEmailModel!.msg.toString());
                              });
                            },
                            child: Text(
                              'Send Code',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
