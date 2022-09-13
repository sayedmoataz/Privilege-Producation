// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables, non_constant_identifier_names, curly_braces_in_flow_control_structures, unused_element, no_logic_in_create_state, avoid_print, avoid_unnecessary_containers, unused_import, unused_local_variable, unnecessary_new, duplicate_ignore, file_names, unused_field, sized_box_for_whitespace, avoid_types_as_parameter_names, unrelated_type_equality_checks, body_might_complete_normally_nullable

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/Modules/Login_Signup/Sign_Up.dart';
import '/Modules/Login_Signup/forgot_password.dart';
import '/Modules/Login_Signup/verification.dart';
import '/Modules/Menu_Screens/contact_us_screen.dart';
import '/Shared/UI/Drawer/custom_drawer.dart';
import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/auth_models/login_model.dart';
import '../../Shared/UI/components.dart';
import '../Home_Pages/home_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailcontroller = TextEditingController();
    var _formKey = GlobalKey<FormState>();
    var passwordController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
            body: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
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
                  SizedBox(height: 60),
                  MyTextFormField(
                    context: context,
                    controller: emailcontroller,
                    hint: cubit.isEnglish
                        ? 'Mail "Required"'
                        : 'البريد الإلكتروني "مطلوب"',
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: cubit.isLoginPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return cubit.isEnglish
                            ? 'Password contain of 8 character at least'
                            : 'تتكون كلمة السر من 8 أحرف علي الأقل';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: cubit.isEnglish
                          ? 'password "Required"'
                          : 'كلمة السر "مطلوبة"',
                      suffixIcon: InkWell(
                        child: cubit.isLoginPassword
                            ? Icon(
                                Icons.visibility_off,
                                color: HexColor('#0029e7'),
                              )
                            : Icon(
                                Icons.visibility,
                                color: HexColor('#dd2634'),
                              ),
                        onTap: () {
                          cubit.changeLoginPasswordVisibility();
                        },
                      ),
                      contentPadding: EdgeInsets.all(20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    TextButton(
                      onPressed: () {
                        NavigateTo(context, ForgotPassword());
                      },
                      child: Text(
                        cubit.isEnglish
                            ? 'Forget Password?'
                            : 'نسيت كلمة السر ؟',
                        style: TextStyle(color: HexColor('#0029e7')),
                      ),
                    )
                  ]),
                  SizedBox(height: 20.0),
                  Container(
                      width: double.infinity,
                      height: 50.0,
                      child: cubit.isLoadingAuth
                          ? Center(
                              child: CircularProgressIndicator(
                              color: HexColor('#0029e7'),
                            ))
                          : MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              color: HexColor('#0029e7'),
                              onPressed: () {
                                cubit.loadingAuthScreens(true);
                                cubit
                                    .login(
                                        email: emailcontroller.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  if (cubit.loginModel!.code == 203) {
                                    cubit.loadingAuthScreens(false);
                                    CacheHelper.putData(
                                            key: 'email',
                                            value: emailcontroller.text)
                                        .then((value) {
                                      navigateFinalTo(context, Verification());
                                    });
                                  } else if (cubit.loginModel!.code == 200) {
                                    CacheHelper.putData(
                                            key: 'token',
                                            value:
                                                cubit.loginModel!.data!.token)
                                        .then((value) {
                                      if (value) {
                                        CacheHelper.putData(
                                                key: 'email',
                                                value: cubit
                                                    .loginModel!.data!.email)
                                            .then((value) {
                                          CacheHelper.putData(
                                                  key: 'uid',
                                                  value: cubit
                                                      .loginModel!.data!.id
                                                      .toString())
                                              .then((value) {
                                            if (value) {
                                              cubit.loadingAuthScreens(false);
                                              cubit.getAllUniversities();
                                              cubit.getFavoritesCourses();
                                              cubit.getProfileData();
                                              cubit.getUserArray();
                                              cubit.getUserCourses();
                                              cubit.getAllNotifications();
                                              cubit.aboutUs();
                                              navigateFinalTo(
                                                  context, HomePage());
                                            }
                                          });
                                        });
                                      }
                                    });
                                  } else if (cubit.loginModel!.code == 204) {
                                    cubit.loadingAuthScreens(false);
                                    Fluttertoast.showToast(
                                            msg:
                                                "Your Email doesn't exist, You can Sign up now")
                                        .then((value) {
                                      NavigateTo(context, SignUp());
                                    });
                                  } else if (cubit.loginModel!.code == 202) {
                                    cubit.loadingAuthScreens(false);
                                    Fluttertoast.showToast(
                                            msg:
                                                "You're Suspended, Please Contact us Now.")
                                        .then((value) {
                                      NavigateTo(context, ContactUsScreen());
                                    });
                                  }
                                }).catchError((e) {
                                  cubit.loadingAuthScreens(false);
                                  Fluttertoast.showToast(
                                      msg: 'Invalid email or password');
                                });
                              },
                              child: Text(
                                  cubit.isEnglish ? 'LOG-IN' : 'تسجيل الدخول',
                                  style: TextStyle(color: Colors.white)),
                            )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            cubit.isEnglish ? 'First Time?' : 'أول مرة',
                            style: TextStyle(color: HexColor('#616363')),
                          ),
                          TextButton(
                              onPressed: () {
                                navigateFinalTo(context, SignUp());
                              },
                              child: Text(
                                cubit.isEnglish
                                    ? "Sign-up now"
                                    : 'الأشتراك الآن',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#0029e7')),
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  TextButton(
                      onPressed: () {
                        NavigateTo(context, ContactUsScreen());
                      },
                      child: Text(
                        cubit.isEnglish ? 'Contact Us' : 'تواصل معنا',
                        style: TextStyle(color: HexColor('#0029e7')),
                      )),
                  /*Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /*// facr book
                      SignInButton(
                        Buttons.Facebook,
                        onPressed: () async {
                          cubit.signInWithFacebook().then((val) {
                            CacheHelper.putData(key: 'socialToken', value: val)
                                .then((value) async {
                              if (value) {
                                cubit
                                    .login(
                                        email: FirebaseAuth
                                            .instance.currentUser!.email
                                            .toString(),
                                        phone: FirebaseAuth
                                            .instance.currentUser!.phoneNumber
                                            .toString(),
                                        name: FirebaseAuth
                                            .instance.currentUser!.displayName
                                            .toString())
                                    .then((value) {
                                  if (cubit.loginModel!.code == 200) {
                                    CacheHelper.putData(
                                            key: 'token',
                                            value:
                                                cubit.loginModel!.data!.token)
                                        .then((value) {
                                      if (value) {
                                        CacheHelper.putData(
                                                key: 'email',
                                                value: cubit
                                                    .loginModel!.data!.email)
                                            .then((value) {
                                          CacheHelper.putData(
                                                  key: 'uid',
                                                  value: cubit
                                                      .loginModel!.data!.id
                                                      .toString())
                                              .then((value) {
                                            if (value) {
                                              cubit.getAllUniversities();
                                              cubit.getFavoritesCourses();
                                              cubit.getProfileData();
                                              cubit.getUserArray();
                                              cubit.getUserCourses();
                                              cubit.getAllNotifications();
                                              cubit.aboutUs();
                                              navigateFinalTo(
                                                  context, HomePage());
                                            }
                                          });
                                        });
                                      }
                                    });
                                  } else if (cubit.loginModel!.code == 204) {
                                    Fluttertoast.showToast(
                                        msg: cubit.isEnglish
                                            ? 'something wrong'
                                            : "حدث خطأ ما");
                                  }
                                }).catchError((e) {
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? 'something wrong'
                                          : "حدث خطأ ما");
                                });
                              }
                            });
                          }).catchError((e) {
                            print(e.toString());
                          });
                        },
                      ),
                      Divider(thickness: 3, endIndent: 150, indent: 150),*/
                      // apple
                      if (Platform.isIOS)
                        SignInButton(
                          Buttons.Apple,
                          onPressed: () async {
                            await cubit.signInWithApple().then((val) {
                              CacheHelper.putData(
                                      key: 'socialToken', value: val.toString())
                                  .then((value) {
                                if (value) {
                                  cubit
                                      .login(
                                          email: FirebaseAuth
                                              .instance.currentUser!.email
                                              .toString(),
                                          phone: FirebaseAuth
                                              .instance.currentUser!.phoneNumber
                                              .toString(),
                                          name: FirebaseAuth
                                              .instance.currentUser!.displayName
                                              .toString())
                                      .then((value) {
                                    if (cubit.loginModel!.code == 200) {
                                      CacheHelper.putData(
                                              key: 'token',
                                              value:
                                                  cubit.loginModel!.data!.token)
                                          .then((value) {
                                        if (value) {
                                          CacheHelper.putData(
                                                  key: 'email',
                                                  value: cubit
                                                      .loginModel!.data!.email)
                                              .then((value) {
                                            CacheHelper.putData(
                                                    key: 'uid',
                                                    value: cubit
                                                        .loginModel!.data!.id
                                                        .toString())
                                                .then((value) {
                                              if (value) {
                                                cubit.getAllUniversities();
                                                cubit.getFavoritesCourses();
                                                cubit.getProfileData();
                                                cubit.getUserArray();
                                                cubit.getUserCourses();
                                                cubit.getAllNotifications();
                                                cubit.aboutUs();
                                                navigateFinalTo(
                                                    context, HomePage());
                                              }
                                            });
                                          });
                                        }
                                      });
                                    } else if (cubit.loginModel!.code == 204) {
                                      Fluttertoast.showToast(
                                          msg: cubit.isEnglish
                                              ? 'something wrong'
                                              : "حدث خطأ ما");
                                    }
                                  }).catchError((e) {
                                    Fluttertoast.showToast(
                                        msg: cubit.isEnglish
                                            ? 'something wrong'
                                            : "حدث خطأ ما");
                                  });
                                }
                              });
                            }) /*.catchError((e) {
                              print(e.toString());
                            })*/
                                ;
                          },
                        ),
                      // google
                      if (Platform.isAndroid)
                        SignInButton(
                          Buttons.Google,
                          onPressed: () async{
                            await cubit.signInWithGoogle().then((val) {
                              CacheHelper.putData(
                                key: 'socialToken', value: val.toString()).then((value) {
                                if (value) {
                                  cubit.login(
                                    email: FirebaseAuth.instance.currentUser!.email.toString(),
                                    phone: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                                    name: FirebaseAuth.instance.currentUser!.displayName.toString())
                                  .then((value) {
                                    if (cubit.loginModel!.code == 200) {
                                      CacheHelper.putData(
                                        key: 'token',
                                        value: cubit.loginModel!.data!.token).then((value) {
                                          if (value) {
                                            CacheHelper.putData(
                                              key: 'email',
                                              value: cubit.loginModel!.data!.email).then((value) {
                                                CacheHelper.putData(
                                                  key: 'uid',
                                                  value: cubit.loginModel!.data!.id.toString())
                                                .then((value) {
                                                  if (value) {
                                                    cubit.getAllUniversities();
                                                    cubit.getFavoritesCourses();
                                                    cubit.getProfileData();
                                                    cubit.getUserArray();
                                                    cubit.getUserCourses();
                                                    cubit.getAllNotifications();
                                                    cubit.aboutUs();
                                                  navigateFinalTo(context, HomePage());
                                                  }
                                                });
                                              });
                                          }
                                        });
                                    } else if (cubit.loginModel!.code == 204) {
                                      Fluttertoast.showToast(
                                        msg: cubit.isEnglish? 'something wrong': "حدث خطأ ما");
                                    }
                                  }).catchError((e) {
                                    Fluttertoast.showToast(
                                      msg: cubit.isEnglish? 'something wrong': "حدث خطأ ما");
                                  });
                                }
                              });
                            }) /*.catchError((e) {
                              print(e.toString());
                            })*/
                                ;
                          },
                        ),
                    ],
                  ),*/
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
