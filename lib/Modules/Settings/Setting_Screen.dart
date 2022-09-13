// ignore_for_file: file_names, prefer_const_constructors, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_print, unused_import, prefer_const_constructors_in_immutables, unnecessary_null_comparison, non_constant_identifier_names, avoid_types_as_parameter_names, use_key_in_widget_constructors, deprecated_member_use, unused_element

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/Login_Signup/login_screen.dart';
import '/Modules/Login_Signup/verification.dart';
import '/Modules/Menu_Screens/contact_us_screen.dart';
import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/auth_models/register_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../Home_Pages/home_page.dart';
import '../Menu_Screens/Notification_Screen.dart';
import '../search/search.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Declare your method channel varibale here

  @override
  void initState() {
    // this method to user can't take screenshot your application

    super.initState();
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        //CacheHelper.putData(key: "image", value: imageTemporary);
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(msg: "Failed To Pick Image $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var universityController = TextEditingController();
    var phoneController = TextEditingController();
    if (CacheHelper.getData(key: 'token') != null) {
      nameController.text = HomeCubit.profileModel!.data!.name.toString();
      emailController.text = HomeCubit.profileModel!.data!.email.toString();
      phoneController.text = HomeCubit.profileModel!.data!.phone.toString();
      universityController.text =
          HomeCubit.profileModel!.data!.university.toString() == 'null'
              ? ''
              : HomeCubit.profileModel!.data!.university.toString();
    }
    final ImagePicker picker = ImagePicker();
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
                title: cubit.isEnglish ? 'Edit Profile' : 'تعديل البيانات'),
            drawer: CustomDrawer(isEnglish: cubit.isEnglish),
            resizeToAvoidBottomInset: true,
            body: CacheHelper.getData(key: 'token') == null
                ? Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset(
                              'assets/1.png',
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              cubit.isEnglish
                                  ? 'Please Login to edit your profile'
                                  : 'الرجاء تسجيل الدخول لتعديل بياناتك',
                              style: TextStyle(
                                  fontSize: 25, color: HexColor('#616363')),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: HexColor('#0029e7'),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              cubit.isEnglish
                                  ? 'Login Now '
                                  : 'تسجيل الدخول الآن',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 122,
                              height: 122,
                              child: InkWell(
                                onTap: () => pickImage(),
                                child: Stack(
                                  children: [
                                    image != null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            radius: 60,
                                            child: ClipOval(
                                              child: Image.file(
                                                image!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            radius: 60,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: CachedNetworkImage(
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error,
                                                            size: 60,
                                                            color: HexColor(
                                                                '#0029e7')),
                                                imageUrl: HomeCubit
                                                    .profileModel!.data!.photo!,
                                              ),
                                            ),
                                          ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: HexColor('#0029e7')),
                                            child: Icon(Icons.camera,
                                                size: 35, color: Colors.white)))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 40),
                            MyTextFormField(
                                context: context,
                                controller: nameController,
                                hint: cubit.isEnglish
                                    ? 'Full name (required)'
                                    : 'الاسم "مطلوب"',
                                inputType: TextInputType.name),
                            SizedBox(height: 20.0),
                            MyTextFormField(
                                context: context,
                                controller: emailController,
                                hint: cubit.isEnglish
                                    ? 'E-Mail (required)'
                                    : 'البريد الإلكتروني "مطلوب"',
                                inputType: TextInputType.emailAddress),
                            SizedBox(height: 20),
                            TextFormField(
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: cubit.isRegisterPassword,
                              decoration: InputDecoration(
                                hintText: cubit.isEnglish
                                    ? 'Password (optional)'
                                    : 'كلمة السر " إختياري"',
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(20),
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
                                ),
                              ),
                              validator: (Value) {
                                return 'password must be 8 charcters';
                              },
                            ),
                            SizedBox(height: 20),
                            MyTextFormField(
                                context: context,
                                controller: universityController,
                                hint: cubit.isEnglish
                                    ? 'University  (optional)'
                                    : 'الجامعة "إختياري"',
                                inputType: TextInputType.text),
                            SizedBox(height: 20),
                            MyTextFormField(
                                context: context,
                                controller: phoneController,
                                hint: cubit.isEnglish
                                    ? 'Mobile Phone (optional)'
                                    : 'رقم الهاتف "مطلوب"',
                                inputType: TextInputType.phone),
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
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      color: HexColor('#0029e7'),
                                      onPressed: () async {
                                        cubit.loadingAuthScreens(true);
                                        await cubit
                                            .editProfile(
                                                emailController.text,
                                                passwordController.text,
                                                phoneController.text,
                                                universityController
                                                        .text.isEmpty
                                                    ? HomeCubit.profileModel!
                                                        .data!.university
                                                        .toString()
                                                    : universityController.text,
                                                '',
                                                nameController.text.isEmpty
                                                    ? HomeCubit.profileModel!
                                                        .data!.name
                                                        .toString()
                                                    : nameController.text,
                                                context)
                                            .then((value) {
                                          cubit.loadingAuthScreens(false);
                                        }).catchError((e) {
                                          cubit.loadingAuthScreens(false);
                                          Fluttertoast.showToast(
                                              msg: cubit
                                                  .errorRegister['message']);
                                        });
                                      },
                                      child: Text(
                                          cubit.isEnglish ? 'Update' : 'تعديل',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              width: double.infinity,
                              height: 50.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                color: HexColor('#0029e7'),
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          title: Text(
                                            cubit.isEnglish
                                                ? 'Are you sure you want to delete your account?'
                                                : 'هل أنت متأكد من أنك تريد حذف حسابك؟',
                                          ),
                                          actions: [
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              color: HexColor('#0029e7'),
                                              onPressed: () async {
                                                await cubit
                                                    .deleteAccount(context)
                                                    .then((value) {})
                                                    .catchError((e) {});
                                              },
                                              child: Text(
                                                  cubit.isEnglish
                                                      ? 'Yes'
                                                      : 'نعم',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                            MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              color: HexColor('#0029e7'),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                  cubit.isEnglish ? 'NO' : 'لا',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        );
                                      });
                                  // await
                                  //     .then((value) {
                                  //   cubit.loadingAuthScreens(false);
                                  // }).catchError((e) {
                                  //   cubit.loadingAuthScreens(false);
                                  //   Fluttertoast.showToast(
                                  //       msg: cubit
                                  //           .errorRegister['message']);
                                  // });
                                },
                                child: Text(
                                    cubit.isEnglish
                                        ? 'Delete Account '
                                        : 'حذف الحساب',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
