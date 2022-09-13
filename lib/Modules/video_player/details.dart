// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print, sized_box_for_whitespace, unused_import

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:privilege/cubit/cubit.dart';

import '/Modules/instructor/instructor.dart';
import '/Shared/local/cache_helper.dart';
import '/models/courses_models/one_course.dart';
import '/models/courses_models/one_user_course.dart';
import '/models/instructor/instructor_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.courseId}) : super(key: key);
  final String courseId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // Declare your method channel varibale here

  OneCourseModel? oneCourseModel;

  Future<void> getOneUserCourse() async {
    var uri = Uri.parse(
        'https://www.privilegeapps.com/api/course/${widget.courseId}');
    await http.get(uri, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}'
    }).then((value) {
      setState(() {
        oneCourseModel = OneCourseModel.fromJson(jsonDecode(value.body));
      });
      print(oneCourseModel!.data!.instructor!.name);
    }).catchError((e) {
      print(e.toString());
    });
  }

  InstructorModel? instructorModel;

  Future<void> getInstructorData(String id) async {
    var uri = Uri.parse('https://www.privilegeapps.com/api/instructor/$id');
    await http.get(uri, headers: {
      'Authorization': 'Bearer ${CacheHelper.getData(key: 'token')}',
      "Accept": "application/json"
    }).then((value) {
      setState(() {
        instructorModel = InstructorModel.fromJson(jsonDecode(value.body));
      });
      print(instructorModel!.data!.name);
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    getOneUserCourse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: oneCourseModel == null
          ? Center(child: CircularProgressIndicator(color: HexColor('#0029e7')))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    // University Image
                    Container(
                        color: Colors.white10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // University Name
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      oneCourseModel!.data!.name.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: HexColor('#0029e7')),
                                    ),
                                  ),
                                  // Faculaties And Students
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.grey[300]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(0.0),
                                                child: CachedNetworkImage(
                                                  height: 60,
                                                  width: 60,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error,
                                                              size: 50,
                                                              color: HexColor(
                                                                  '#0029e7')),
                                                  imageUrl: oneCourseModel!
                                                      .data!.instructor!.photo
                                                      .toString(),
                                                ),
                                              ),
                                              FittedBox(
                                                  child: Row(
                                                children: [
                                                  Text(
                                                    'Instructor: ',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: HexColor(
                                                            '#0029e7')),
                                                  ),
                                                  Text(
                                                    oneCourseModel!
                                                        .data!.instructor!.name
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    oneCourseModel!.data!.description
                                        .toString(),
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                            // const Spacer(),
                            // button
                          ],
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
