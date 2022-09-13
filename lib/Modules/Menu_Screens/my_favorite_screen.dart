// ignore_for_file: prefer_const_constructors, duplicate_ignore, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Modules/Login_Signup/login_screen.dart';
import 'package:privilege/Shared/UI/components.dart';
import 'package:privilege/Shared/local/cache_helper.dart';

import '/Modules/content_modules/one_course_screen.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/materials/favorite_materials_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({Key? key}) : super(key: key);

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
                  title: cubit.isEnglish ? 'Favouirte' : 'المفضلة'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: cubit.favoritesModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: HexColor('#0029e7'),
                    ))
                  : CacheHelper.getData(key: 'token') == null
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Image.asset(
                                    'assets/1.png',
                                  ),
                                ),
                                FittedBox(
                                  child: Text(
                                    cubit.isEnglish
                                        ? 'Please Login to see your favorite courses'
                                        : 'يرجى تسجيل الدخول لمشاهدة الدورات المفضلة',
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: HexColor('#616363')),
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
                      : Container(
                          child: cubit.favoritesModel!.data.isEmpty
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: 200,
                                      color: HexColor('#0029e7'),
                                    ),
                                    FittedBox(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        cubit.isEnglish
                                            ? 'No Favourite Courses'
                                            : 'لا يوجد دورات مفضلة',
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: HexColor('#dd2634')),
                                      ),
                                    ))
                                  ],
                                ))
                              : ListView.builder(
                                  itemCount: cubit.favoritesModel!.data.length,
                                  itemBuilder: (context, index) =>
                                      buildFavouriteItem(
                                          cubit.favoritesModel!, cubit, () {
                                        cubit
                                            .getOneCourse(cubit
                                                .favoritesModel!.data[index].id
                                                .toString())
                                            .then((value) {
                                          if (cubit
                                              .userArrayModel!.data!.myCourses
                                              .contains(cubit.favoritesModel!
                                                  .data[index].id)) {
                                            cubit.checkCourseBought(true);
                                            /*if (cubit.userArrayModel!.data!.myRates
                                          .contains(cubit.favoritesModel!
                                              .data[index].id)) {
                                        cubit.checkCourseRated(true);
                                      } else {
                                        cubit.checkCourseRated(false);
                                      }*/
                                          } else {
                                            cubit.checkCourseBought(false);
                                          }
                                          NavigateTo(context, OneCourseScreen());
                                        });
                                      }, context, index)),
                        ),
            ),
          );
        });
  }

  Widget buildFavouriteItem(FavouriteCoursesModel model, HomeCubit cubit,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              // University Image
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    CachedNetworkImage(
                      errorWidget: (context, url, error) 
                      =>Icon(Icons.error,size: 60),
                      imageUrl: model.data[index].photo.toString(),
                      height: 200,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    if(cubit.aboutUsModel!.check != true)
                      if ((model.data[index].price!.toInt()) <
                          (model.data[index].realPrice!.toInt()))
                            Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 80,
                            width: 60,
                            child: model.data[index].price == 0
                            ? Center(
                              child: Text(
                                cubit.isEnglish ? 'Free' : 'مجاني',
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            )
                            : Center(
                              child: Text(
                                cubit.isEnglish
                                ? "${(((model.data[index].realPrice!.toInt() - model.data[index].price!.toInt()) / model.data[index].realPrice!.toInt()) * 100).toInt()}% \n off"
                                : "${(((model.data[index].realPrice!.toInt() - model.data[index].price!.toInt()) / model.data[index].realPrice!.toInt()) * 100).toInt()}% \n خصم",
                                style: TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          ),
                        )
                  ],
                ),
              ),
              // University Name -- term
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
                              style: const TextStyle(fontSize: 25,color: Colors.black,),
                            ),
                          ),
                          // term -- type
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if ( model.data[index].term != null)
                                Row(
                                  children: [
                                    Text(
                                  cubit.isEnglish? 'TERM:': 'الفصل ' ,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20,color: HexColor('#0029e7'),),
                                ),
                                    Text(
                                  model.data[index].term.toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20,color : HexColor('#616363')),
                                ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(children: [
                                  Text(
                                  cubit.isEnglish
                                  ? 'TYPE: '
                                  : 'النوع: ',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20,color: HexColor('#0029e7')),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  cubit.isEnglish
                                  ? model.data[index].type == 1 ? 'Mainstream' : 'Credit'
                                  : model.data[index].type == 1 ? 'نظام فصلي' : 'ساعات معتمدة',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20,color: HexColor('#616363')),
                                ),
                                ],),
                                
                                
                              ],
                            ),
                          ),
                          // favourite
                          Row(
                            children: [
                              /*Text(
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
                                */
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  cubit.deleteCourseFavorite(
                                    cubit.favoritesModel!.data[index].id.toString())
                                  .then((value) {
                                    cubit.getFavoritesCourses();
                                    cubit.getUserArray();
                                  });
                                },
                                icon: Icon(Icons.favorite),
                                iconSize: 40,
                                color: Colors.red,
                              )
                            ],
                          ),
                          // price And views
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  if(cubit.aboutUsModel!.check != true)
                                    model.data[index].price == 0
                                    ? Text(cubit.isEnglish? 'price: Free': ' السعر : مجاني ',style: TextStyle(fontSize: 18))
                                    : Text(
                                      cubit.isEnglish? 'price: ${model.data[index].price}  EGP   ': 'السعر: ${model.data[index].price}  EGP'   ,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    if(cubit.aboutUsModel!.check != true)
                                      if ((model.data[index].price!.toInt()) <
                                          (model.data[index].realPrice!.toInt()))
                                          Text(
                                            model.data[index].realPrice.toString()+'  EGP',
                                            style: TextStyle(fontSize: 18,color: HexColor('#dd2634'),
                                            decoration: TextDecoration.lineThrough),
                                          ),
                                    SizedBox(width: 20),
                                    Text(
                                      cubit.isEnglish
                                      ? 'views:  ${model.data[index].view}'
                                      : 'المشاهدات:  ${model.data[index].view}',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                ],
                              ),
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
        ),
    );*/
  }
}
