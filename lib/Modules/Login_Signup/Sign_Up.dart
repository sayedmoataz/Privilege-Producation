// ignore_for_file: file_names, prefer_const_constructors, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_print, unused_import, prefer_const_constructors_in_immutables, unnecessary_null_comparison, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/Login_Signup/login_screen.dart';
import '/Modules/Login_Signup/verification.dart';
import '/Modules/Menu_Screens/contact_us_screen.dart';
import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/auth_models/register_model.dart';
import '../Home_Pages/home_page.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordController2 = TextEditingController();
    var universityController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        //cubit.isRegisterPassword = obs;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/3.png',
                      scale: 6,
                    )),
                    SizedBox(height: 60),
                    MyTextFormField(
                      context: context,
                      controller: nameController,
                      hint: 'Full name',
                      inputType: TextInputType.name,
                    ),
                    SizedBox(height: 20.0),
                    MyTextFormField(
                      context: context,
                      controller: emailController,
                      hint: 'E-Mail',
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.isRegisterPassword,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          suffixIcon: InkWell(
                            onTap: () {
                              cubit.changeRegisterPasswordVisibility();
                            },
                            child: cubit.isRegisterPassword
                                ? Icon(
                                    Icons.visibility_off,
                                    color: HexColor('#0029e7'),
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: HexColor('#dd2634'),
                                  ),
                          )),
                      validator: (Value) {
                        return 'password must be 8 charcters';
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      controller: passwordController2,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: cubit.isRegisterPassword2,
                      decoration: InputDecoration(
                          hintText: 're-enter Password',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10),
                          suffixIcon: InkWell(
                            onTap: () {
                              cubit.changeRegisterPasswordVisibility2();
                            },
                            child: cubit.isRegisterPassword2
                                ? Icon(
                                    Icons.visibility_off,
                                    color: HexColor('#0029e7'),
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: HexColor('#dd2634'),
                                  ),
                          )),
                      validator: (Value) {
                        return 'password must be 8 charcters';
                      },
                    ),
                    SizedBox(height: 20),
                    MyTextFormField(
                      context: context,
                      controller: universityController,
                      hint: 'University  (optional)',
                      inputType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    MyTextFormField(
                      context: context,
                      controller: phoneController,
                      hint: 'Phone Number (Optional)',
                      inputType: TextInputType.phone,
                    ),
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
                              onPressed: () async {
                                if (passwordController.text ==
                                    passwordController2.text) {
                                  cubit.loadingAuthScreens(true);
                                  await cubit
                                      .register(
                                          context: context,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          university: universityController.text)
                                      .catchError((e) {
                                    cubit.loadingAuthScreens(false);
                                    Fluttertoast.showToast(
                                        msg: 'error while registering');
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: cubit.isEnglish
                                          ? 'two passwords are not the same'
                                          : 'كلمتا السر ليسوا متشابهان');
                                }
                              },
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Have An Account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Text(
                            "Log-in now",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: HexColor('#0029e7')),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      onPressed: () {
                        NavigateTo(context, ContactUsScreen());
                      },
                      child: Text(
                        'Contact Us',
                        style: TextStyle(color: HexColor('#0029e7')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
