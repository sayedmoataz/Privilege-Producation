// ignore_for_file: prefer_const_constructors, unused_import, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/video_player/material.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/courses_models/user_courses_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/local/cache_helper.dart';
import '../Login_Signup/login_screen.dart';
import '../content_modules/one_course_screen.dart';
import '../search/search.dart';
import 'Notification_Screen.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  title: cubit.isEnglish ? 'My Courses' : 'دوراتي التعليمية'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: CacheHelper.getData(key: 'token') == null
                  ? SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.asset(
                                'assets/1.png',
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                cubit.isEnglish
                                    ? 'Please Login to see your  courses'
                                    : 'يرجى تسجيل الدخول لمشاهدة دوراتك',
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
                  : cubit.userCoursesModel == null
                      ? Center(
                          child: CircularProgressIndicator(
                          color: HexColor('#0029e7'),
                        ))
                      : SafeArea(
                          child: cubit.userCoursesModel!.data.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.menu_book_sharp,
                                      size: 200,
                                      color: HexColor('#0029e7'),
                                    ),
                                    FittedBox(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.isEnglish
                                            ? 'You Don\'t Have Any Courses Yet'
                                            : 'لم تقم بشراء أي دورة بعد',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: HexColor('#dd2634')),
                                      ),
                                    ))
                                  ],
                                ))
                              : ListView.builder(
                                  itemCount:
                                      cubit.userCoursesModel!.data.length,
                                  itemBuilder: (context, index) =>
                                      buildCourseItem(
                                          cubit, cubit.userCoursesModel!, () {
                                        cubit
                                            .getOneCourse(cubit
                                                .userCoursesModel!
                                                .data[index]
                                                .id
                                                .toString())
                                            .then((value) {
                                          if (cubit
                                              .userArrayModel!.data!.myCourses
                                              .contains(cubit.userCoursesModel!
                                                  .data[index].id)) {
                                            cubit.checkCourseBought(true);
                                            /*if (cubit
                                                  .userArrayModel!.data!.myRates
                                                  .contains(cubit
                                                      .oneLevelModel!
                                                      .data!
                                                      .courses[index]
                                                      .id)) {
                                                cubit.checkCourseRated(true);
                                              } else {
                                                cubit.checkCourseRated(false);
                                              }*/
                                          } else {
                                            cubit.checkCourseBought(false);
                                          }
                                        });
                                        NavigateTo(context, OneCourseScreen());
                                      }, context, index)),
                        ),
            ),
          );
        });
  }

  Widget buildCourseItem(HomeCubit cubit, UserCoursesModel model,
      VoidCallback buttonAction, BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: InkWell(
          onTap: buttonAction,
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .2,
                  height: 75,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 60),
                    imageUrl: model.data[index].photo.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.data[index].name.toString(),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22, color: HexColor('#0029e7')),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                                model.data[index].term == null
                                    ? ''
                                    : cubit.isEnglish
                                        ? 'TERM:'
                                        : 'الفصل الدراسي',
                                style: TextStyle(
                                    fontSize: 18, color: HexColor('#0029e7'))),
                            Text(
                              model.data[index].term.toString(),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, color: HexColor('#616363')),
                            ),
                            const SizedBox(width: 5),
                            Text(
                                model.data[index].type == null
                                    ? ''
                                    : cubit.isEnglish
                                        ? 'TYPE:'
                                        : 'النظام الدراسي',
                                style: TextStyle(
                                    fontSize: 18, color: HexColor('#0029e7'))),
                            Text(
                              model.data[index].type == null
                                  ? ''
                                  : cubit.isEnglish
                                      ? (model.data[index].type == 1
                                          ? 'Mainstream'
                                          : 'Credit')
                                      : (model.data[index].type == 1
                                          ? 'نظام فصلي'
                                          : 'ساعات معتمدة'),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: HexColor('#616363'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit
                          .deleteCourseFavorite(
                              cubit.favoritesModel!.data[index].id.toString())
                          .then((value) {
                        cubit.getFavoritesCourses();
                        cubit.getUserArray();
                      });
                    },
                    icon: Icon(Icons.favorite),
                    iconSize: 35,
                    color: CacheHelper.getData(key: 'token') == null
                        ? HexColor('#616363')
                        : cubit.userArrayModel!.data!.myFavorite
                                .contains(model.data[index].id)
                            ? HexColor('#dd2634')
                            : HexColor('#616363'))
              ],
            ),
          )),
    );

    /*InkWell(
        onTap: buttonAction,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
          children: [
            // University Image
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => Icon(Icons.error,size: 60),
                imageUrl: model.data[index].photo.toString(),
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            // University Name -- type -- term
            Container(
              color: Colors.white10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            model.data[index].name.toString(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 25,color: HexColor('#0029e7')),
                          ),
                        ),
                        // term -- type 
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                cubit.isEnglish ? 'TERM: ' : 'الفصل الدراسي',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20,color: HexColor('#0029e7')),
                              ),
                              SizedBox(width: 5),
                              Text(
                                model.data[index].term.toString(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20,color: HexColor('#616363')),
                              ),
                              ],),
                              SizedBox(height: 5),
                               Row(children: [
                                Text(
                                cubit.isEnglish ? 'TYPE : ' : 'النظام التعليمي : ',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20,color: HexColor('#0029e7')),
                              ),
                              SizedBox(width: 5),
                              Text(
                                model.data[index].type == 1 ? 'Mainstream' : 'Credit',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 20,color: HexColor('#616363')),
                              ),
                              
                            ],
                          ),
                       
                        /*Row(
                            children: [
                              Spacer(),
                              Text(
                                'rate: ',
                                style: TextStyle(fontSize: 20),
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 20,
                                initialRating:
                                    model.data[index].rate!.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),*/
                        // Views
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Text(
                                'views: ',
                                style: TextStyle(fontSize: 18 , color : HexColor('#0029e7')),
                              ),
                              Text(
                                model.data[index].view.toString(),
                                style: TextStyle(fontSize: 18 , color : HexColor('#616363')),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            )
          ],
        ),
            
      )
          ]
          )));
  */
  }
}
