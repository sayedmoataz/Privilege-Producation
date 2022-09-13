
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import '../content_modules/one_course_screen.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/search_models/search_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/UI/components.dart';
import '../../Shared/local/cache_helper.dart';
import '../Login_Signup/login_screen.dart';
import '../Menu_Screens/Notification_Screen.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection:
              cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
          child: Scaffold(
              //backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
              appBar: AppBar(
                title: Text(cubit.isEnglish ? 'Search' : 'بحث'),
                backgroundColor: HexColor('#0029e7'),
                systemOverlayStyle:
                    SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                    icon: const Icon(Icons.notifications_active),
                    padding: const EdgeInsets.only(right: 10.0),
                  ),
                ],
              ),
              key: scaffoldKey,
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 7),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextFormField(
                          onChanged: (String value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter video name';
                            } else
                              return null;
                          },
                          controller: HomeCubit.get(context).searchController,
                          decoration: InputDecoration(
                            hintText: cubit.isEnglish
                                ? 'write something'
                                : 'عن ماذا تبحث',
                            prefixIcon:
                                Icon(Icons.search, color: HexColor('#0029e7')),
                            filled: true,
                            fillColor: Colors.grey[300],
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(color: HexColor('#0029e7')),
                        child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                HomeCubit.get(context)
                                    .search(cubit.searchController.text);
                              },
                              child: Text(
                                cubit.isEnglish ? 'Search' : 'بحث',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )),
                      ),
                      HomeCubit.get(context).searchModel == null
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search,
                                    size: 200, color: HexColor('#0029e7')),
                                FittedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    cubit.isEnglish
                                        ? 'Write Something To Search'
                                        : 'عن ماذا تبحث ؟',
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: HexColor('#dd2634')),
                                  ),
                                ))
                              ],
                            ))
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) =>
                                      buildSearchItem(
                                          context,
                                          cubit.searchModel!.data[index],
                                          cubit),
                                  itemCount: HomeCubit.get(context)
                                      .searchModel!
                                      .data
                                      .length),
                            )
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }

  Widget buildSearchItem(context, Data model, HomeCubit cubit) {
    return InkWell(
      onTap: CacheHelper.getData(key: 'token') != null
          ? () {
              cubit.getOneCourse(model.id.toString()).then((value) {
                if (cubit.userArrayModel!.data!.myCourses.contains(model.id)) {
                  cubit.checkCourseBought(true);
                } else {
                  cubit.checkCourseBought(false);
                }
                NavigateTo(context, OneCourseScreen());
              });
            }
          : () {
              Fluttertoast.showToast(
                  msg: cubit.isEnglish
                      ? 'Please Login First'
                      : 'الرجاء تسجيل الدخول أولا');
              NavigateTo(context, const LoginScreen());
            },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            width: double.infinity,
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, s, p) =>
                                const Padding(padding: EdgeInsets.all(18.0)),
                            errorWidget: (context, string, dynamic) => const Padding(
                              padding: EdgeInsets.all(10),
                              child:
                                  Icon(Icons.error_outline, color: Colors.red),
                            ),
                            imageUrl: model.photo.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (model.term != null)
                          Row(
                            children: [
                              Text(
                                cubit.isEnglish ? 'TERM: ' : 'الفصل الدراسي',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#0029e7')),
                              ),
                              Text(
                                '${model.term}',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#616363')),
                              ),
                            ],
                          ),
                        const SizedBox(height: 5),
                        // type
                        if (model.type != null)
                          Row(
                            children: [
                              Text(
                                cubit.isEnglish
                                    ? 'TYPE : '
                                    : 'النظام الدراسي : ',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#0029e7')),
                              ),
                              Text(
                                cubit.isEnglish
                                    ? model.type == 1
                                        ? 'Mainstream'
                                        : 'Credit'
                                    : model.type == 1
                                        ? 'نظام فصلي'
                                        : 'ساعات معتمدة',
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#616363')),
                              ),
                            ],
                          ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (CacheHelper.getData(key: 'token') != null)
                              if (cubit.aboutUsModel!.check != false)
                                model.price == 0
                                    ? Text('price: Free',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: HexColor('#dd2634')))
                                    : Row(
                                        children: [
                                          Text(
                                              cubit.isEnglish
                                                  ? 'price : '
                                                  : 'السعر : ',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: HexColor('#0029e7'))),
                                          Text('${model.price}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: HexColor('#616363'))),
                                        ],
                                      ),
                            const SizedBox(width: 5),
                            if (CacheHelper.getData(key: 'token') != null)
                              if (cubit.aboutUsModel!.check != false)
                                if ((model.price!.toInt()) <
                                    (model.realPrice!.toInt()))
                                  Text(
                                    model.realPrice.toString(),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
