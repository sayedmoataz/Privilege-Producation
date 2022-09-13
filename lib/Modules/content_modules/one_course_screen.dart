import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Shared/instructor_item.dart';
import '../../Shared/material_items.dart';
import '../payment/payfrom.dart';
import '/Modules/video_player/material.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../../Shared/UI/components.dart';
import '../../Shared/local/cache_helper.dart';
import '../Login_Signup/login_screen.dart';

class OneCourseScreen extends StatelessWidget {
  OneCourseScreen({Key? key}) : super(key: key);
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: cubit.oneCourseModel == null
                  ? Center(
                  child: CircularProgressIndicator(color: HexColor('#0029e7')))
                  : SingleChildScrollView(
                  child: cubit.isUpdatingCourseFev
                      ? Center(child: CircularProgressIndicator(
                      color: HexColor('#0029e7')))
                      : RefreshIndicator(
                      onRefresh: () async {
                        cubit.getOneCourse(
                            cubit.oneCourseModel!.data!.id.toString());
                      },
                      child: SafeArea(
                        child: Column(
                            children: [
                              // image ++ amount off
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Stack(
                                  alignment: AlignmentDirectional.topStart,
                                  children: [
                                    CachedNetworkImage(
                                      errorWidget: (context, url, error) =>
                                      const Icon(Icons.error, size: 60),
                                      imageUrl: cubit.oneCourseModel!.data!
                                          .photo.toString(),
                                      height: 200,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    if (Platform.isAndroid)
                                      if ((cubit.oneCourseModel!.data!.price!
                                          .toInt()) >
                                          (cubit.oneCourseModel!.data!
                                              .realPrice!.toInt()))
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            height: 80,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                color: HexColor('#0029e7'),
                                                borderRadius: const BorderRadius
                                                    .only(bottomRight: Radius
                                                    .circular(10),
                                                    bottomLeft: Radius.circular(
                                                        10))
                                            ),
                                            child: cubit.oneCourseModel!.data!
                                                .price == 0
                                                ? Center(
                                              child: Text(
                                                cubit.isEnglish
                                                    ? 'Free'
                                                    : 'مجاني',
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white),
                                              ),
                                            )
                                                : Center(
                                              child: Text(
                                                "${(((cubit.oneCourseModel!
                                                    .data!.price!.toInt() -
                                                    cubit.oneCourseModel!.data!
                                                        .realPrice!.toInt()) /
                                                    cubit.oneCourseModel!.data!
                                                        .price!.toInt()) * 100)
                                                    .toInt()}% \n off",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                    if (Platform.isIOS)
                                      if (CacheHelper.getData(key: 'token') != null)
                                        if (cubit.aboutUsModel!.check != false)
                                          if ((cubit.oneCourseModel!.data!
                                              .price!.toInt()) >
                                              (cubit.oneCourseModel!.data!
                                                  .realPrice!.toInt()))
                                            Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(horizontal: 10),
                                              child: Container(
                                                height: 80,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    color: HexColor('#0029e7'),
                                                    borderRadius: const BorderRadius
                                                        .only(
                                                        bottomRight: Radius
                                                            .circular(10),
                                                        bottomLeft: Radius
                                                            .circular(10)
                                                    )
                                                ),
                                                child: cubit.oneCourseModel!
                                                    .data!.price == 0
                                                    ? Center(
                                                  child: Text(
                                                    cubit.isEnglish
                                                        ? 'Free'
                                                        : 'مجاني',
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                )
                                                    : Center(
                                                  child: Text(
                                                    "${(((cubit.oneCourseModel!
                                                        .data!.price!.toInt() -
                                                        cubit.oneCourseModel!
                                                            .data!.realPrice!
                                                            .toInt()) /
                                                        cubit.oneCourseModel!
                                                            .data!.price!
                                                            .toInt()) * 100)
                                                        .toInt()}% \n off",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )
                                  ],
                                ),
                              ),
                              // name + term & type
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                      color: Colors.white10,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                // name
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5),
                                                  child: Text(
                                                    cubit.oneCourseModel!.data!
                                                        .name.toString(),
                                                    textAlign: TextAlign.center,
                                                    maxLines: 3,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: HexColor(
                                                            '#0029e7')),
                                                  ),
                                                ),
                                                // term & type
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      // term
                                                      Row(
                                                        children: [
                                                          Text(
                                                            cubit
                                                                .oneCourseModel!
                                                                .data!.term ==
                                                                null
                                                                ? ''
                                                                : cubit
                                                                .isEnglish
                                                                ? 'TERM: '
                                                                : 'الفصل الدراسي: ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: HexColor(
                                                                    '#0029e7')),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            cubit
                                                                .oneCourseModel!
                                                                .data!.term ==
                                                                null
                                                                ? ''
                                                                : cubit
                                                                .isEnglish
                                                                ? cubit
                                                                .oneCourseModel!
                                                                .data!.term
                                                                .toString()
                                                                : cubit
                                                                .oneCourseModel!
                                                                .data!.term
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: HexColor(
                                                                    '#616363')),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 5),
                                                      // type
                                                      Row(
                                                        children: [
                                                          Text(
                                                            cubit.isEnglish
                                                                ? 'TYPE: '
                                                                : 'النوع: ',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: HexColor(
                                                                    '#0029e7')),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            cubit.isEnglish
                                                                ? cubit
                                                                .oneCourseModel!
                                                                .data!.type == 1
                                                                ? 'Mainstream'
                                                                : 'Credit'
                                                                : cubit
                                                                .oneCourseModel!
                                                                .data!.type == 1
                                                                ? 'نظامي فصلي'
                                                                : 'ساعات معتمدة',
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: HexColor(
                                                                    '#616363')),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Rate & Calender & Favouirte
                                                Row(
                                                  children: [
                                                    if (CacheHelper.getData(
                                                        key: "token") != null)
                                                      TextButton(
                                                        onPressed: () {
                                                          var contentTitle = TextFormField(
                                                            controller: titleController,
                                                            autofocus: true,
                                                            keyboardType: TextInputType
                                                                .name,
                                                            decoration: const InputDecoration(
                                                                labelText: 'Workout Name'),
                                                          );
                                                          var contentDate = TextFormField(
                                                              controller: dateController,
                                                              autofocus: true,
                                                              keyboardType: TextInputType
                                                                  .datetime,
                                                              decoration: const InputDecoration(
                                                                  labelText: 'Workout date')
                                                          );
                                                          var btn = FlatButton(
                                                            child: const Text(
                                                                'Save'),
                                                            onPressed: () {
                                                              cubit
                                                                  .insertToDatabase(
                                                                  title: titleController
                                                                      .text
                                                                      .toString(),
                                                                  date: dateController
                                                                      .text
                                                                      .toString());
                                                              Navigator.of(
                                                                  context).pop(
                                                                  false);
                                                            },
                                                          );
                                                          var cancelButton = FlatButton(
                                                              child: const Text(
                                                                  'Cancel'),
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                      context)
                                                                      .pop(
                                                                      false));
                                                          showDialog(
                                                            context: context,
                                                            builder: (
                                                                BuildContext context) =>
                                                                Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          6)),
                                                                  elevation: 0.0,
                                                                  backgroundColor: Colors
                                                                      .transparent,
                                                                  child: Stack(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            6),
                                                                        decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          shape: BoxShape
                                                                              .rectangle,
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              6),
                                                                          boxShadow: const [
                                                                            BoxShadow(
                                                                              color: Colors
                                                                                  .black26,
                                                                              blurRadius: 10.0,
                                                                              offset: Offset(
                                                                                  0.0,
                                                                                  10.0),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child: SingleChildScrollView(
                                                                          child: Column(
                                                                            mainAxisSize: MainAxisSize
                                                                                .min,
                                                                            children: <
                                                                                Widget>[
                                                                              const SizedBox(
                                                                                  height: 5.0),
                                                                              const Text(
                                                                                  "Reminder Your study Hours"),
                                                                              Container(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      20),
                                                                                  child: contentTitle),
                                                                              Container(
                                                                                  padding: const EdgeInsets
                                                                                      .all(
                                                                                      20),
                                                                                  child: contentDate),
                                                                              Row(mainAxisSize: MainAxisSize
                                                                                  .min,
                                                                                  children: <
                                                                                      Widget>[
                                                                                    btn,
                                                                                    cancelButton
                                                                                  ]),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                          );
                                                        },
                                                        child: const Text(
                                                            "Add To Calendar"),
                                                      ),
                                                    const Spacer(),
                                                    IconButton(
                                                      padding: const EdgeInsets
                                                          .all(0),
                                                      onPressed: () {
                                                        if (CacheHelper.getData(
                                                            key: 'token') ==
                                                            null) {
                                                          Fluttertoast
                                                              .showToast(
                                                              msg: cubit
                                                                  .isEnglish
                                                                  ? 'Please Login First'
                                                                  : 'الرجاء تسجيل الدخول أولا');
                                                          NavigateTo(context,
                                                              const LoginScreen());
                                                        } else {
                                                          if (cubit
                                                              .userArrayModel!
                                                              .data!.myFavorite
                                                              .contains(cubit
                                                              .oneCourseModel!
                                                              .data!.id)) {
                                                            cubit
                                                                .deleteCourseFavorite(
                                                                cubit
                                                                    .oneCourseModel!
                                                                    .data!.id
                                                                    .toString())
                                                                .then((value) {
                                                              cubit
                                                                  .updatingCourseFev(
                                                                  true);
                                                              cubit
                                                                  .getUserArray()
                                                                  .then((
                                                                  value) {
                                                                cubit
                                                                    .updatingCourseFev(
                                                                    false);
                                                                cubit
                                                                    .getFavoritesCourses();
                                                              });
                                                            });
                                                          } else {
                                                            cubit
                                                                .addCourseFavorite(
                                                                cubit
                                                                    .oneCourseModel!
                                                                    .data!.id
                                                                    .toString())
                                                                .then((value) {
                                                              cubit
                                                                  .updatingCourseFev(
                                                                  true);
                                                              cubit
                                                                  .getUserArray()
                                                                  .then((
                                                                  value) {
                                                                cubit
                                                                    .updatingCourseFev(
                                                                    false);
                                                                cubit
                                                                    .getFavoritesCourses();
                                                              });
                                                            });
                                                          }
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.favorite),
                                                      iconSize: 35,
                                                      color: CacheHelper
                                                          .getData(
                                                          key: 'token') == null
                                                          ? HexColor('#616363')
                                                          : cubit
                                                          .userArrayModel!.data!
                                                          .myFavorite.contains(
                                                          cubit.oneCourseModel!
                                                              .data!.id)
                                                          ? HexColor('#dd2634')
                                                          : HexColor('#616363'),
                                                    )
                                                  ],
                                                ),
                                                // price
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis
                                                        .horizontal,
                                                    child: Platform.isIOS
                                                        ? Row(
                                                            children: [
                                                              if (CacheHelper.getData(key: 'token') !=null)
                                                                if (cubit.aboutUsModel!.check != false)
                                                                  cubit.oneCourseModel!.data!.price == 0
                                                                      ? Text(
                                                                        cubit.isEnglish ? 'price: Free' : 'السعر : مجاني',
                                                                        style: TextStyle(fontSize: 18,color: HexColor('#dd2634'))
                                                                      )
                                                                      : Row(
                                                              children: [
                                                                Text(
                                                                  cubit
                                                                      .isEnglish
                                                                      ? 'price : '
                                                                      : 'السعر : ',
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: HexColor(
                                                                          '#0029e7')),
                                                                ),
                                                                Text(
                                                                  "${cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .realPrice
                                                                      .toString()} EGP",
                                                                  style: TextStyle(
                                                                      fontSize: 18,
                                                                      color: HexColor(
                                                                          '#616363')),
                                                                )
                                                              ],
                                                            ),
                                                              if (CacheHelper.getData(key: 'token') != null)
                                                                if (cubit.aboutUsModel!.check != false)
                                                                  if ((cubit.oneCourseModel!.data!.price!.toInt()) > (cubit.oneCourseModel!.data!.realPrice!.toInt()))
                                                                    Text(
                                                                "${cubit
                                                                    .oneCourseModel!
                                                                    .data!
                                                                    .price
                                                                    .toString()} EGP",
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    color: HexColor(
                                                                        '#dd2634'),
                                                                    decoration: TextDecoration
                                                                        .lineThrough),
                                                              ),
                                                              if (cubit.aboutUsModel!.check != false)
                                                                const SizedBox(width: 20),
                                                              Row(
                                                          children: [
                                                            Text(
                                                                cubit.isEnglish
                                                                    ? 'Views : '
                                                                    : 'عدد المشاهدات : ',
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: HexColor(
                                                                        '#0029e7'))
                                                            ),
                                                            Text(
                                                                cubit
                                                                    .oneCourseModel!
                                                                    .data!.view
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: HexColor(
                                                                        '#616363'))
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                        : Row(
                                                      children: [
                                                        cubit.oneCourseModel!
                                                            .data!.price == 0
                                                            ? Text(
                                                            cubit.isEnglish
                                                                ? 'price: Free'
                                                                : 'السعر : مجاني',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: HexColor(
                                                                    '#dd2634'))
                                                        )
                                                            : Row(
                                                          children: [
                                                            Text(
                                                              cubit.isEnglish
                                                                  ? 'price : '
                                                                  : 'السعر : ',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: HexColor(
                                                                      '#0029e7')),
                                                            ),
                                                            Text(
                                                              "${cubit
                                                                  .oneCourseModel!
                                                                  .data!.realPrice
                                                                  .toString()} EGP",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: HexColor(
                                                                      '#616363')),
                                                            )
                                                          ],
                                                        ),
                                                        if ((cubit
                                                            .oneCourseModel!
                                                            .data!.price!
                                                            .toInt()) > (cubit
                                                            .oneCourseModel!
                                                            .data!.realPrice!
                                                            .toInt()))
                                                          Text(
                                                            "${cubit
                                                                .oneCourseModel!
                                                                .data!.price
                                                                .toString()} EGP",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: HexColor(
                                                                    '#dd2634'),
                                                                decoration: TextDecoration
                                                                    .lineThrough),
                                                          ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                cubit.isEnglish
                                                                    ? 'Views : '
                                                                    : 'عدد المشاهدات : ',
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: HexColor(
                                                                        '#0029e7'))
                                                            ),
                                                            Text(
                                                                cubit
                                                                    .oneCourseModel!
                                                                    .data!.view
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color: HexColor(
                                                                        '#616363'))
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                // instructor
                                                buildInstructorItem(
                                                    context,
                                                    cubit.oneCourseModel!.data!
                                                        .instructor!.photo
                                                        .toString(),
                                                    cubit.oneCourseModel!.data!
                                                        .instructor!.name
                                                        .toString(),
                                                    cubit.oneCourseModel!.data!
                                                        .name.toString(),
                                                        () {},
                                                    1
                                                ),
                                                // buy course
                                                cubit.isCourseBought
                                                    ? Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 10),
                                                          // go to course
                                                          MaterialButton(
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                            child: Text(
                                                                Platform.isIOS
                                                                    ? cubit.isEnglish
                                                                    ? 'Start Learning'
                                                                    : 'لنبدأ التعلم'
                                                                    : cubit.isEnglish
                                                                    ? 'Already Enrolled'
                                                                    : 'بالفعل مسجل',
                                                                style: const TextStyle(
                                                                    fontSize: 20,
                                                                    color: Colors.white)
                                                            ),
                                                            color: HexColor("#f6d246"),
                                                            onPressed: () {},
                                                            height: 60,
                                                            minWidth: 110,
                                                          ),
                                                  ],
                                                )
                                                    : MaterialButton(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(20)),
                                                    child: Text(
                                                      CacheHelper.getData(
                                                          key: 'token') != null
                                                          ? Platform.isIOS
                                                          ? cubit.isEnglish
                                                          ? 'Add to My Courses'
                                                          : 'إضافة الي كورساتي'
                                                          : cubit.isEnglish
                                                          ? 'Enroll' : 'التسجيل'
                                                          : cubit.isEnglish
                                                          ? ' Login First'
                                                          : "تسجيل الدخول",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                    color: HexColor('#f6d246'),
                                                    onPressed: () async {
                                                      if (CacheHelper.getData(
                                                          key: 'token') ==
                                                          null) {
                                                        Fluttertoast.showToast(
                                                            msg: cubit.isEnglish
                                                                ? 'Please Login First'
                                                                : 'الرجاء تسجيل الدخول أولا');
                                                        NavigateTo(context,
                                                            const LoginScreen());
                                                      } else {
                                                        if (cubit
                                                            .oneCourseModel!
                                                            .data!.realPrice ==
                                                            0) {
                                                          cubit.buyCourse(cubit
                                                              .oneCourseModel!
                                                              .data!.id
                                                              .toString())
                                                              .then((value) {
                                                            Fluttertoast
                                                                .showToast(
                                                                msg: cubit
                                                                    .buyCourseModel!
                                                                    .msg
                                                                    .toString());
                                                            cubit
                                                                .checkCourseBought(
                                                                true);
                                                            cubit
                                                                .getUserArray();
                                                            cubit
                                                                .getUserCourses();
                                                            cubit.getOneCourse(
                                                                cubit
                                                                    .oneCourseModel!
                                                                    .data!.id
                                                                    .toString())
                                                                .then((
                                                                value) {});
                                                          });
                                                        } else {
                                                          NavigateTo(context,
                                                              PayFrom(
                                                                  isCourse: true,
                                                                  phoneNumber: cubit
                                                                      .aboutUsModel!
                                                                      .data!
                                                                      .whatsPhone
                                                                      .toString()));
                                                        }
                                                      }
                                                    },
                                                    height: 60,
                                                    minWidth: 110
                                                ),
                                                const SizedBox(height: 20),
                                                // descripation
                                                Text(
                                                  '${cubit.oneCourseModel!.data!
                                                      .description}',
                                                  style: TextStyle(fontSize: 22,
                                                      fontWeight: FontWeight
                                                          .w300,
                                                      color: HexColor(
                                                          '#616363')),
                                                ),
                                                const SizedBox(height: 30),
                                                // materials
                                                Text(
                                                  cubit.isEnglish
                                                      ? 'Materials'
                                                      : 'المواد',
                                                  style: TextStyle(fontSize: 22,
                                                      color: HexColor(
                                                          '#dd2634')),
                                                ),
                                                const SizedBox(height: 30),
                                                // all materials to buy
                                                CustomScrollView(
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  slivers: [
                                                    SliverList(
                                                      delegate: SliverChildBuilderDelegate((
                                                          context, index) =>
                                                          buildMaterialItem(
                                                              cubit,
                                                              index,
                                                              context,
                                                              cubit.oneCourseModel!.data!.materials[index].name.toString(),
                                                              cubit.oneCourseModel!.data!.materials[index].description,
                                                              cubit.aboutUsModel!.check !=false,
                                                              cubit.oneCourseModel!.data!.materials[index].viewNumber! > 1,
                                                              cubit.isEnglish ? 'you can watch it ${cubit.oneCourseModel!.data!.materials[index].viewNumber} times': 'يمكنك مشاهدته ${cubit.oneCourseModel!.data!.materials[index].viewNumber} مرات',
                                                              CacheHelper
                                                                  .getData(
                                                                  key: 'token') ==
                                                                  null
                                                                  ? MaterialButton(
                                                                color: HexColor(
                                                                    '#f6d246'),
                                                                child: Text(
                                                                  cubit
                                                                      .isEnglish
                                                                      ? "Login First"
                                                                      : "تسجيل الدخول",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 12),
                                                                  maxLines: 2,
                                                                ),
                                                                height: 50,
                                                                minWidth: 100,
                                                                onPressed: () {
                                                                  if (CacheHelper
                                                                      .getData(
                                                                      key: 'token') ==
                                                                      null) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                        msg: cubit
                                                                            .isEnglish
                                                                            ? 'Please Login First'
                                                                            : 'الرجاء تسجيل الدخول أولا');
                                                                    NavigateTo(
                                                                        context,
                                                                        const LoginScreen());
                                                                  }
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10)),
                                                              )
                                                                  : cubit
                                                                  .userArrayModel!
                                                                  .data!
                                                                  .myCourses
                                                                  .contains(
                                                                  cubit
                                                                      .oneCourseModel!
                                                                      .data!.id)
                                                                  ? MaterialButton(
                                                                color: HexColor(
                                                                    '#0029e7'),
                                                                child: Text(
                                                                  cubit
                                                                      .isEnglish
                                                                      ? 'Watch Now'
                                                                      : 'المشاهدة الآن',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 15),
                                                                ),
                                                                height: 50,
                                                                onPressed: () async {
                                                                  await cubit
                                                                      .getOneMaterial(
                                                                      cubit
                                                                          .oneCourseModel!
                                                                          .data!
                                                                          .materials[index]
                                                                          .id
                                                                          .toString())
                                                                      .then((
                                                                      value) async {
                                                                    await cubit
                                                                        .getOneUserCourse(
                                                                        cubit
                                                                            .oneCourseModel!
                                                                            .data!
                                                                            .id
                                                                            .toString())
                                                                        .then((
                                                                        value) {
                                                                      NavigateTo(
                                                                          context,
                                                                          VideoPlayerScreen(
                                                                            courseId: cubit
                                                                                .oneCourseModel!
                                                                                .data!
                                                                                .id
                                                                                .toString(),
                                                                            comments: cubit
                                                                                .oneUserCourseModel!
                                                                                .data!
                                                                                .comments,
                                                                            materials: cubit
                                                                                .oneMaterialModel!,
                                                                            initialUrl: cubit
                                                                                .aboutUsModel!
                                                                                .check ==
                                                                                true
                                                                                ? cubit
                                                                                .oneMaterialModel!
                                                                                .data!
                                                                                .file
                                                                                .toString()
                                                                                : cubit
                                                                                .oneMaterialModel!
                                                                                .data!
                                                                                .video
                                                                                .toString(),
                                                                          )
                                                                      );
                                                                    });
                                                                  });
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10)),
                                                              )
                                                                  : cubit
                                                                  .userArrayModel!
                                                                  .data!
                                                                  .myMaterials
                                                                  .contains(
                                                                  cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .materials[index]
                                                                      .id)
                                                                  ? MaterialButton(
                                                                color: HexColor(
                                                                    '#0029e7'),
                                                                child: Text(
                                                                  cubit
                                                                      .isEnglish
                                                                      ? 'Watch Now'
                                                                      : 'المشاهدة الآن',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 15),
                                                                ),
                                                                height: 50,
                                                                onPressed: () async {
                                                                  await cubit
                                                                      .getOneMaterial(
                                                                      cubit
                                                                          .oneCourseModel!
                                                                          .data!
                                                                          .materials[index]
                                                                          .id
                                                                          .toString())
                                                                      .then((
                                                                      value) {
                                                                    NavigateTo(
                                                                        context,
                                                                        VideoPlayerScreen(
                                                                            courseId: cubit
                                                                                .oneCourseModel!
                                                                                .data!
                                                                                .id
                                                                                .toString(),
                                                                            materials: cubit
                                                                                .oneMaterialModel!,
                                                                            initialUrl: cubit
                                                                                .aboutUsModel!
                                                                                .check ==
                                                                                true
                                                                                ? cubit
                                                                                .oneMaterialModel!
                                                                                .data!
                                                                                .file
                                                                                .toString()
                                                                                : cubit
                                                                                .oneMaterialModel!
                                                                                .data!
                                                                                .video
                                                                                .toString()
                                                                        )
                                                                    );
                                                                  });
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10)),
                                                              )
                                                                  : MaterialButton(
                                                                color: HexColor(
                                                                    '#f6d246'),
                                                                child: Text(
                                                                  cubit
                                                                      .aboutUsModel!
                                                                      .check !=
                                                                      true
                                                                      ? cubit
                                                                      .isEnglish
                                                                      ? cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .materials[index]
                                                                      .price ==
                                                                      '0.00'
                                                                      ? 'Free'
                                                                      : '${cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .materials[index]
                                                                      .price}EGP  buy'
                                                                      .toString()
                                                                      : cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .materials[index]
                                                                      .price ==
                                                                      '0.00'
                                                                      ? 'مجاني'
                                                                      : '${cubit
                                                                      .oneCourseModel!
                                                                      .data!
                                                                      .materials[index]
                                                                      .price}  شراء  EGP'
                                                                      .toString()
                                                                      : "Enroll",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 12),
                                                                  maxLines: 2,
                                                                ),
                                                                height: 50,
                                                                minWidth: 100,
                                                                onPressed: () {
                                                                  if (CacheHelper
                                                                      .getData(
                                                                      key: 'token') ==
                                                                      null) {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                        msg: cubit
                                                                            .isEnglish
                                                                            ? 'Please Login First'
                                                                            : 'الرجاء تسجيل الدخول أولا');
                                                                    NavigateTo(
                                                                        context,
                                                                        LoginScreen());
                                                                  } else {
                                                                    if (cubit
                                                                        .oneCourseModel!
                                                                        .data!
                                                                        .materials[index]
                                                                        .price ==
                                                                        '0.00') {
                                                                      cubit
                                                                          .updatingCourseFev(
                                                                          true);
                                                                      cubit
                                                                          .buyMaterial(
                                                                          cubit
                                                                              .oneCourseModel!
                                                                              .data!
                                                                              .materials[index]
                                                                              .id
                                                                              .toString())
                                                                          .then((
                                                                          value) {
                                                                        Fluttertoast
                                                                            .showToast(
                                                                            msg: cubit
                                                                                .buyMaterialModel!
                                                                                .msg
                                                                                .toString());
                                                                        cubit
                                                                            .getUserArray();
                                                                        cubit
                                                                            .getOneCourse(
                                                                            cubit
                                                                                .oneCourseModel!
                                                                                .data!
                                                                                .id
                                                                                .toString())
                                                                            .then((
                                                                            value) {
                                                                          cubit
                                                                              .updatingCourseFev(
                                                                              false);
                                                                        });
                                                                      });
                                                                    } else {
                                                                      NavigateTo(
                                                                          context,
                                                                          PayFrom(
                                                                            isCourse: false,
                                                                            phoneNumber: cubit
                                                                                .aboutUsModel!
                                                                                .data!
                                                                                .whatsPhone
                                                                                .toString(),
                                                                            materialId: cubit
                                                                                .oneCourseModel!
                                                                                .data!
                                                                                .materials[index]
                                                                                .id
                                                                                .toString(),
                                                                            materialName: cubit
                                                                                .oneCourseModel!
                                                                                .data!
                                                                                .materials[index]
                                                                                .name
                                                                                .toString(),
                                                                          ));
                                                                    }
                                                                  }
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10)),
                                                              ),
                                                              1
                                                          ),
                                                          childCount: cubit
                                                              .oneCourseModel!
                                                              .data!.materials
                                                              .length
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                  )
                              ),
                            ]
                        ),
                      )
                  )
              )
          );
        }
    );
  }
}