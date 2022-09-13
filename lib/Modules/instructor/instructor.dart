// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_import, avoid_print, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/instructor/instructor_model.dart';

class InstructorData extends StatelessWidget {
  const InstructorData({Key? key, required this.instructorModel})
      : super(key: key);
  final InstructorModel instructorModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: myappbar(
                context: context,
                title: cubit.isEnglish ? 'Instructor' : 'المحاضر'),
            body: instructorModel == null
                ? Center(
                    child: CircularProgressIndicator(
                    color: HexColor('#0029e7'),
                  ))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // photo
                        Container(
                          height: 250,
                          width: double.infinity,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: CachedNetworkImage(
                                        imageUrl: instructorModel.data!.photo
                                            .toString(),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error, size: 50),
                                      )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // name
                                      instructorModel.data!.name
                                              .toString()
                                              .isNotEmpty
                                          ? Container(
                                              width: 200,
                                              child: Text(
                                                '${instructorModel.data!.name.toString()}',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                          : Text(''),
                                      // email
                                      /*instructorModel.data!.email.toString().isNotEmpty
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    ' ${instructorModel.data!.email.toString()}',
                                    style: TextStyle(fontSize: 24 , color: HexColor('#f6d246')),
                                  )
                                ),
                              )
                              : Text(' '),*/
                                      // phone
                                      instructorModel.data!.phone
                                              .toString()
                                              .isNotEmpty
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: FittedBox(
                                                  child: Text(
                                                '${instructorModel.data!.phone.toString()}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: HexColor('#f6d246')),
                                              )),
                                            )
                                          : Text(' '),
                                      // university
                                      /*instructorModel.data!.university.toString().isNotEmpty
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    '${instructorModel.data!.university.toString()}',
                                    style: TextStyle(fontSize: 24 , color: HexColor('#f6d246')),
                                  )
                                ),
                              )
                              : Text(' '),*/
                                      /*// facebook
                            instructorModel.data!.facebookId.toString().isNotEmpty
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    '${instructorModel.data!.facebookId.toString()}',
                                    style: TextStyle(fontSize: 24 , color: Colors.white),
                                  )
                                ),
                              )
                              : Text('Facebook isn\'t available'),*/
                                    ],
                                  ),
                                ],
                              )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50)),
                              color: HexColor('#0029e7')),
                        ),

                        // rate
                        /*RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: instructorModel.data!.rate!.toDouble(),
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),*/
                        // courses word
                        // Row(
                        //     mainAxisAlignment: cubit.isEnglish
                        //     ? MainAxisAlignment.start
                        //     : MainAxisAlignment.end,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: FittedBox(
                        //           child: Text(
                        //             cubit.isEnglish ? 'Courses:' : 'الدورات',
                        //             textAlign: cubit.isEnglish
                        //               ? TextAlign.left
                        //               : TextAlign.right,
                        //             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        //           )
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // Divider(),
                        // SizedBox(height: 8),
                        // // courses
                        // ListView.builder(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: instructorModel.data!.coursesCount,
                        //   itemBuilder: (context, index) =>
                        //   buildCourseItem(instructorModel , cubit,() {
                        //     cubit.getOneCourse(instructorModel.data!.courses[index].id.toString()).then((value) {
                        //       if (cubit.userArrayModel!.data!.myCourses.contains(instructorModel.data!.courses[index].id)) {
                        //         cubit.checkCourseBought(true);
                        //         /*if (cubit.userArrayModel!.data!.myRates
                        //                         .contains(instructorModel
                        //                             .data!.courses[index].id)) {
                        //                       cubit.checkCourseRated(true);
                        //                     } else {
                        //                       cubit.checkCourseRated(false);
                        //                     }*/
                        //       } else {cubit.checkCourseBought(false);}
                        //       NavigateTo(context, OneCourse());
                        //     });
                        //   }, context, index))
                      ],
                    ),
                  ),
          );
        });
  }

  Widget buildCourseItem(InstructorModel model, HomeCubit cubit,
      VoidCallback buttonAction, BuildContext context, int index) {
    return InkWell(
      onTap: buttonAction,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            // University Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  CachedNetworkImage(
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 60,
                    ),
                    imageUrl: model.data!.courses[index].photo.toString(),
                    height: 200,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
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
                                  'Free',
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.white),
                                ),
                              )
                            : Center(
                                child: Text(
                                  cubit.isEnglish
                                      ? "${(((model.data!.courses[index].realPrice!.toInt() - model.data!.courses[index].price!.toInt()) / model.data!.courses[index].realPrice!.toInt()) * 100).toInt()}% \n off"
                                      : "${(((model.data!.courses[index].realPrice!.toInt() - model.data!.courses[index].price!.toInt()) / model.data!.courses[index].realPrice!.toInt()) * 100).toInt()}% \n خصم",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                        decoration: BoxDecoration(
                            color: HexColor('#0029e7'),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      cubit.isEnglish
                                          ? 'term : '
                                          : 'الفصل الدراسي:  ',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: HexColor('#0029e7')),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      model.data!.courses[index].term
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: HexColor('#616363')),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      cubit.isEnglish
                                          ? 'TYPE : '
                                          : 'النظام التعليمي',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: HexColor('#0029e7')),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      model.data!.courses[index].type == 1
                                          ? 'Mainstream'
                                          : 'Credit',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: HexColor('#616363')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          /*Row(
                            children: [
                              Spacer(),
                              /*Text(
                                'rate: ',
                                style: TextStyle(fontSize: 20),
                              ),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: model.data!.rate!.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            */],
                          ),*/

                          // Faculaties And Students
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        model.data!.courses[index].price == 0
                                            ? Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                    Text('price :',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: HexColor(
                                                                '#0029e7'))),
                                                    Text('Free',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: HexColor(
                                                                '#616363')))
                                                  ])
                                            : Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                    Text(
                                                        cubit.isEnglish
                                                            ? 'price : '
                                                            : 'السعر :',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: HexColor(
                                                                '#0029e7'))),
                                                    Text(
                                                        model
                                                            .data!
                                                            .courses[index]
                                                            .price
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: HexColor(
                                                                '#616363')))
                                                  ]),
                                        if ((model.data!.courses[index].price!
                                                .toInt()) <
                                            (model
                                                .data!.courses[index].realPrice!
                                                .toInt()))
                                          Text(
                                            model.data!.courses[index].realPrice
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: HexColor('#dd2634'),
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        SizedBox(width: 20),
                                        Row(
                                          children: [
                                            Text(
                                              cubit.isEnglish
                                                  ? 'views : '
                                                  : ' عدد المشاهدات',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: HexColor('#0029e7')),
                                            ),
                                            Text(
                                              model.data!.courses[index].view
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: HexColor('#616363')),
                                            ),
                                          ],
                                        )
                                        // No. Student
                                      ],
                                    ))),
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
    );
  }
}
