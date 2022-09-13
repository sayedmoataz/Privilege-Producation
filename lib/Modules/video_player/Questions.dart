// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, avoid_function_literals_in_foreach_calls, sized_box_for_whitespace, unused_import, unnecessary_import, prefer_const_literals_to_create_immutables, duplicate_ignore, argument_type_not_assignable_to_error_handler, file_names

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:privilege/cubit/cubit.dart';
import 'package:privilege/cubit/states.dart';

import '/Shared/local/cache_helper.dart';
import '/models/courses_models/one_user_course.dart';
import '/models/courses_models/store_messege.dart';

class QAndAScreen extends StatefulWidget {
  const QAndAScreen({
    Key? key,
    this.comments,
    required this.courseId,
  }) : super(key: key);
  final List<Comments>? comments;
  final String courseId;

  @override
  State<QAndAScreen> createState() => _QAndAScreenState();
}

class _QAndAScreenState extends State<QAndAScreen> {
  final controller = TextEditingController();
  bool iSending = false;

  // Declare your method channel varibale here

  @override
  void initState() {
    // this method to user can't take screenshot your application

    super.initState();
  }

  //one user course
  OneUserCourseModel? oneUserCourseModel;

  Future<void> getOneUserCourse() async {
    setState(() {
      widget.comments!.clear();
    });
    var uri = Uri.parse(
        'https://www.privilegeapps.com/api/my-courses/${widget.courseId}');
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      print(value.body);
      setState(() {
        oneUserCourseModel =
            OneUserCourseModel.fromJson(jsonDecode(value.body));
        oneUserCourseModel!.data!.comments.forEach((element) {
          if (!widget.comments!.contains(element)) {
            widget.comments!.add(element);
          }
        });
      });
      print(oneUserCourseModel!.data!.instructor!.name);
    }).catchError((e) {
      print(e.toString());
    });
  }

  StoreMessageModel? storeMessageModel;

  Future<void> storeMessage(String courseId, String message) async {
    var data = {'course_id': courseId, 'message': message};
    var uri = Uri.parse('https://www.privilegeapps.com/api/chat');
    await http
        .post(uri,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
            },
            body: data)
        .then((value) {
      setState(() {
        storeMessageModel = StoreMessageModel.fromJson(jsonDecode(value.body));
      });
      getOneUserCourse();
      print(storeMessageModel!.msg);
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: widget.comments.toString() == 'null'
                  ? Center(
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            size: 100,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FittedBox(
                              child: Text(
                            'Comments are for courses only',
                            style: TextStyle(fontSize: 30, color: Colors.grey),
                          ))
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        widget.comments.toString() == '[]'
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(
                                      Icons.comment_rounded,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    FittedBox(
                                        child: Text(
                                      'No Comments',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.grey),
                                    ))
                                  ],
                                ),
                              )
                            : Container(
                                //height: MediaQuery.of(context).size.height,
                                width: double.infinity,
                                child: Column(children: [
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) =>
                                        buildCommentItem(context, index),
                                    itemCount: widget.comments!.length,
                                  ),
                                  SizedBox(height: 70),
                                ]),
                              ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaY: 15,
                                        sigmaX: 15,
                                      ),
                                      child: Container(
                                        height: size.width / 8,
                                        width: size.width / 1.2,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            right: size.width / 30),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[400],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: TextFormField(
                                          textDirection: TextDirection.rtl,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'value mustn\'t be empty';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: controller,
                                          style: TextStyle(
                                              color: HexColor('#616363')
                                                  .withOpacity(.5)),
                                          cursorColor: Colors.white,
                                          obscureText: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintMaxLines: 1,
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: 'write a Comment',
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                iSending
                                    ? CircularProgressIndicator(
                                        color: HexColor('#0029e7'),
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          /*cubit
                                              .storeMessage(
                                                  widget.courseId.toString(),
                                                  controller.text.toString())
                                              .then((value) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Comment has been sent successfully');
                                            setState(() { });
                                          }).catchError(() {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Failed to send your comment');
                                          });*/
                                          if (controller.text.isEmpty) {
                                          } else {
                                            setState(() {
                                              iSending = true;
                                            });
                                            storeMessage(
                                                    widget.courseId.toString(),
                                                    controller.text.toString())
                                                .then((value) {
                                              if (storeMessageModel!.code ==
                                                  201) {
                                                controller.clear();
                                                setState(() {
                                                  iSending = false;
                                                });
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Comment has been sent successfully');
                                              }
                                            }).catchError(() {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Failed to send your comment');
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.send),
                                        iconSize: 35,
                                        color: HexColor('#0029e7'),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )));
        });
  }

  Widget buildCommentItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: HexColor('#0029e7'),
            child: Icon(
              Icons.person,
              size: 35,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: HexColor('#616363')),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.comments![index].message.toString(),
                    style: TextStyle(fontSize: 20, color: HexColor('#616363')),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
