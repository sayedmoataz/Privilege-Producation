
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/local/cache_helper.dart';

import '/Modules/instructor/instructor.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/levels_models/one_level_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/UI/components.dart';
import '../Login_Signup/login_screen.dart';
import '../content_modules/one_course_screen.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

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
              appBar: myappbar(
                  context: context,
                  title: cubit.isEnglish ? "Courses" : 'الكورسات'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: cubit.oneLevelModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: HexColor('#0029e7'),
                      ),
                    )
                  : SafeArea(
                      child: cubit.isUpdatingCourseFev
                          ? Center(
                              child: CircularProgressIndicator(
                              color: HexColor('#0029e7'),
                            ))
                          : Container(
                              child: cubit.oneLevelModel!.data!.courses.isEmpty
                                  ? Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.school,
                                          size: 200,
                                          color: Colors.grey,
                                        ),
                                        FittedBox(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            cubit.isEnglish
                                                ? 'Nc Courses Available In This Level'
                                                : 'لا يوجد كورسات متاحة في هذا المستوى',
                                            style: const TextStyle(
                                                fontSize: 40,
                                                color: Colors.grey),
                                          ),
                                        ))
                                      ],
                                    ))
                                  : ListView.builder(
                                      itemCount: cubit
                                          .oneLevelModel!.data!.courses.length,
                                      itemBuilder: (context, index) =>
                                          buildCourseItem(
                                            cubit,
                                            cubit.oneLevelModel!,
                                            () {
                                              cubit
                                                  .getInstructorData(cubit
                                                      .oneLevelModel!
                                                      .data!
                                                      .courses[index]
                                                      .instructor!
                                                      .id
                                                      .toString())
                                                  .then((value) => NavigateTo(
                                                      context,
                                                      InstructorData(
                                                          instructorModel: cubit
                                                              .instructorModel!)));
                                            },
                                            () {
                                              if (CacheHelper.getData(
                                                      key: 'token') ==
                                                  null) {
                                                cubit
                                                    .getOneCourse(cubit
                                                        .oneLevelModel!
                                                        .data!
                                                        .courses[index]
                                                        .id
                                                        .toString())
                                                    .then((value) {
                                                  cubit
                                                      .checkCourseBought(false);
                                                  NavigateTo(
                                                      context, OneCourseScreen());
                                                });
                                              } else {
                                                cubit
                                                    .getOneCourse(cubit
                                                        .oneLevelModel!
                                                        .data!
                                                        .courses[index]
                                                        .id
                                                        .toString())
                                                    .then((value) {
                                                  if (cubit.userArrayModel!
                                                      .data!.myCourses
                                                      .contains(cubit
                                                          .oneLevelModel!
                                                          .data!
                                                          .courses[index]
                                                          .id)) {
                                                    cubit.checkCourseBought(
                                                        true);
                                                    if (cubit.userArrayModel!
                                                        .data!.myRates
                                                        .contains(cubit
                                                            .oneLevelModel!
                                                            .data!
                                                            .courses[index]
                                                            .id)) {
                                                      cubit.checkCourseRated(
                                                          true);
                                                    } else {
                                                      cubit.checkCourseRated(
                                                          false);
                                                    }
                                                  } else {
                                                    cubit.checkCourseBought(
                                                        false);
                                                  }
                                                });
                                                NavigateTo(
                                                    context, OneCourseScreen());
                                              }
                                            },
                                            context,
                                            index,
                                          )),
                            ),
                    ),
            ),
          );
        });
  }

  Widget buildCourseItem(
      HomeCubit cubit,
      OneLevelModel model,
      VoidCallback instructorData,
      VoidCallback buttonAction,
      BuildContext context,
      int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                        const Icon(Icons.error, size: 60),
                    imageUrl: model.data!.courses[index].photo.toString(),
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
                          model.data!.courses[index].name.toString(),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 22, color: HexColor('#0029e7')),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              if (model.data!.courses[index].term != null)
                                Text(
                                  cubit.isEnglish
                                          ? 'TERM:'
                                          : 'الفصل الدراسي',
                                  style: TextStyle(
                                      fontSize: 18, color: HexColor('#0029e7'))),
                              if (model.data!.courses[index].term != null)
                                Text(
                                model.data!.courses[index].term.toString(),
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#616363')),
                              ),
                              const SizedBox(width: 5),
                              if( model.data!.courses[index].type != null)
                                Text(
                                  cubit.isEnglish
                                          ? 'TYPE:'
                                          : 'النظام الدراسي',
                                  style: TextStyle(
                                      fontSize: 18, color: HexColor('#0029e7'))),
                              if( model.data!.courses[index].type != null)
                                Text(
                                model.data!.courses[index].type == null
                                    ? ''
                                    : cubit.isEnglish
                                        ? (model.data!.courses[index].type == 1
                                            ? 'Mainstream'
                                            : 'Credit')
                                        : (model.data!.courses[index].type == 1
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
                        ),
                      ],
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      if (CacheHelper.getData(key: 'token') == null) {
                        Fluttertoast.showToast(
                            msg: cubit.isEnglish
                                ? 'Please Login First'
                                : 'الرجاء تسجيل الدخول أولا');
                        NavigateTo(context, const LoginScreen());
                      } else {
                        if (cubit.userArrayModel!.data!.myFavorite
                            .contains(model.data!.courses[index].id)) {
                          cubit
                              .deleteCourseFavorite(
                                  model.data!.courses[index].id.toString())
                              .then((value) {
                            cubit.updatingCourseFev(true);
                            cubit.getUserArray().then((value) {
                              cubit.updatingCourseFev(false);
                              cubit.getFavoritesCourses();
                            });
                          });
                        } else {
                          cubit
                              .addCourseFavorite(
                                  model.data!.courses[index].id.toString())
                              .then((value) {
                            cubit.updatingCourseFev(true);
                            cubit.getUserArray().then((value) {
                              cubit.updatingCourseFev(false);
                              cubit.getFavoritesCourses();
                            });
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.favorite),
                    iconSize: 35,
                    color: CacheHelper.getData(key: 'token') == null
                        ? HexColor('#616363')
                        : cubit.userArrayModel!.data!.myFavorite
                                .contains(model.data!.courses[index].id)
                            ? HexColor('#dd2634')
                            : HexColor('#616363'))
              ],
            ),
          )),
    );

    /*InkWell(
        onTap: buttonAction,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              // University Image
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    CachedNetworkImage(
                      errorWidget: (context, url, error) => Icon(Icons.error,size: 60),
                      imageUrl: model.data!.courses[index].photo.toString(),
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    if(CacheHelper.getData(key: 'token')  != null)
                      if(cubit.aboutUsModel!.check != true)
                        if ((model.data!.courses[index].price!.toInt()) <
                            (model.data!.courses[index].realPrice!.toInt()))
                          Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 80,
                            width: 60,
                            child: model.data!.courses[index].price == 0
                            ? Center(
                              child: Text(
                                cubit.isEnglish ? 'Free' : 'مجاني',
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            )
                            : Center(
                              child: Text(
                                "${((( model.data!.courses[index].realPrice!.toInt() - model.data!.courses[index].price!.toInt()) / model.data!.courses[index].realPrice!.toInt()) * 100).toInt()}% \n off",
                                style: TextStyle(
                                  fontSize: 20, color: Colors.white
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: HexColor('#0029e7'),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10)
                              )
                            ),
                          ),
                        )
          
                  ],
                ),
                //     Image.network(
                //   ,
                //   height: 200,
                //   fit: BoxFit.contain,
                //   width: double.infinity,
                // ),
              ),
              // university details
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
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              model.data!.courses[index].name.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 25,
                                color: HexColor('#0029e7'),
                              ),
                            ),
                          ),
                          // creadit or mainstream
                          // term 1 or 2
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8 ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      model.data!.courses[index].term == null ? ''
                                      :cubit.isEnglish
                                        ? 'TERM:': 'الفصل الدراسي' , style: TextStyle(fontSize: 20,color : HexColor('#0029e7')),),
                                    Text(
                                      model.data!.courses[index].term.toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20, color: HexColor('#616363')),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      model.data!.courses[index].type == null ? ''
                                      :cubit.isEnglish
                                        ? 'TYPE:': 'النظام الدراسي' , style: TextStyle(fontSize: 20,color : HexColor('#0029e7')),),
                                    Text(
                                      model.data!.courses[index].type == null ? ''
                                      : cubit.isEnglish
                                        ? (model.data!.courses[index].type == 1 ? 'Mainstream' : 'Credit')
                                        : (model.data!.courses[index].type == 1 ? 'نظام فصلي' : 'ساعات معتمدة'),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 20,color: HexColor('#616363'),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /*Row(
                            children: [
                              TextButton(
                                onPressed: instructorData,
                                child: Text(cubit.isEnglish
                                  ? ("Instructor: ${model.data!.courses[index].instructor!.name.toString()}")
                                  : ("المحاضر: ${model.data!.courses[index].instructor!.name.toString()}")
                                )
                              ),
                              Spacer(),
                              Text(
                                'rate: ',
                                style: TextStyle(fontSize: 20),
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 20,
                                initialRating: cubit
                                    .oneLevelModel!.data!.courses[index].rate!
                                    .toDouble(),
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

                        ]
                          ),
                        */
                          /// go to instructor profile
                          TextButton(
                            onPressed: CacheHelper.getData(key: 'token')  != null? instructorData : (){},
                            child: Text(cubit.isEnglish
                              ? ("Instructor: ${model.data!.courses[index].instructor!.name.toString()}")
                              : ("المحاضر: ${model.data!.courses[index].instructor!.name.toString()}")
                            )
                          ),
                          // price & views & Favouirte
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                                children: [
                                  if(CacheHelper.getData(key: 'token')  != null)
                                    if(cubit.aboutUsModel!.check != true)
                                    model.data!.courses[index].price == 0
                                      ? Text(
                                        cubit.isEnglish ? 'price: Free': 'السعر : مجاني',
                                        style: TextStyle(fontSize: 18 , color: HexColor('#dd2634'))
                                      )
                                      : Row(
                                      children: [
                                      Text(cubit.isEnglish
                                        ? 'price : '
                                        : 'السعر : ',
                                      style: TextStyle(fontSize: 18 , color: HexColor('#0029e7')),),
                                      Text(model.data!.courses[index].price.toString()+'  EGP',
                                      style: TextStyle(fontSize: 18 , color: HexColor('#616363')),)
                                    ],),
                                  if(CacheHelper.getData(key: 'token')  != null)
                                    if(cubit.aboutUsModel!.check != true)
                                      if ((model.data!.courses[index].price!.toInt()) <
                                          (model.data!.courses[index].realPrice!.toInt()))
                                          Text(
                                        model.data!.courses[index].realPrice.toString()+'  EGP',
                                        style: TextStyle(fontSize: 18,color:HexColor('#dd2634'),
                                          decoration: TextDecoration.lineThrough
                                        ),
                                      ),
                                  SizedBox(width: 20),
                                  Row(children: [
                                      Text(cubit.isEnglish
                                        ? 'Views : '
                                        : 'عدد المشاهدات : ',
                                      style: TextStyle(fontSize: 18 , color: HexColor('#0029e7')),),
                                      Text(model.data!.courses[index].view.toString(),
                                      style: TextStyle(fontSize: 18 , color: HexColor('#616363')),)
                                    ],),
                                  Spacer(),
                                  IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      if(CacheHelper.getData(key: 'token')  == null){
                                        Fluttertoast.showToast(msg: cubit.isEnglish ? 'Please Login First' : 'الرجاء تسجيل الدخول أولا');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));

                                      }
                                      else{
                                        if (cubit.userArrayModel!.data!.myFavorite
                                            .contains(model.data!.courses[index].id)) {
                                          cubit.deleteCourseFavorite(
                                              model.data!.courses[index].id.toString()
                                          ).then((value) {
                                            cubit.updatingCourseFev(true);
                                            cubit.getUserArray().then((value) {
                                              cubit.updatingCourseFev(false);
                                              cubit.getFavoritesCourses();
                                            });
                                          });
                                        } else {
                                          cubit.addCourseFavorite(
                                              model.data!.courses[index].id.toString()
                                          ).then((value) {
                                            cubit.updatingCourseFev(true);
                                            cubit.getUserArray().then((value) {
                                              cubit.updatingCourseFev(false);
                                              cubit.getFavoritesCourses();
                                            });
                                          });
                                        }
                                      }

                                    },
                                    icon: Icon(Icons.favorite),
                                    iconSize: 35,
                                    color: CacheHelper.getData(key: 'token')==null?HexColor('#616363'):

                                    cubit.userArrayModel!.data!.myFavorite.contains(model.data!.courses[index].id)
                                      ? HexColor('#dd2634')
                                      : HexColor('#616363')
                                  )
                                  // No. Student
                                ],
                              ),

                          ),
                        ],
                      ),
                    ),
                    // const Spacer(),
                    // button
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      */
  }
}
