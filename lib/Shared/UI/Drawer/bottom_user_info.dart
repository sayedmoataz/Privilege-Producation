// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/Login_Signup/login_screen.dart';
import '/Shared/local/cache_helper.dart';
import '/cubit/cubit.dart';
import '../../../cubit/states.dart';

class BottomUserInfo extends StatelessWidget {
  final bool isCollapsed;
  final bool isEnglish;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
    required this.isEnglish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (HomeCubit.profileModel == null) {
      return Center(
          child: CircularProgressIndicator(
        color: HexColor('#0029e7'),
      ));
    } else {
      return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isCollapsed ? 70 : 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white, //HexColor('#616363'),
                borderRadius: BorderRadius.circular(20),
              ),
              child: isCollapsed
                  ? Center(
                      child: InkWell(
                          onTap: () {
                            CacheHelper.deleteData(key: 'token');
                            if (CacheHelper.getData(key: 'socialToken') !=
                                null) {
                              CacheHelper.deleteData(key: 'socialToken');
                            }
                            CacheHelper.deleteData(key: 'verified');
                            CacheHelper.deleteData(key: 'email');

                            navigateFinalTo(context, LoginScreen());
                          },
                          child: Row(
                            children: [
                              // photo
                              /*Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              size: 25,
                            ),
                            imageUrl: HomeCubit.profileModel!.data!.photo.toString(),
                          )),
                    ),
                    ),
                  ),
                  */
                              // name + university
                              /*Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              HomeCubit.profileModel!.data!.name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            HomeCubit.profileModel!.data!.university.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                        ),
                        ),
                      ],
                    ),
                  ),*/
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(Icons.logout,
                                      color: HexColor('#0029e7'))),
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    CacheHelper.getData(key: 'token') == null
                                        ? (isEnglish ? 'Login' : 'تسجيل الدخول')
                                        : (isEnglish
                                            ? 'Logout'
                                            : 'تسجيل الخروج'),
                                    style: TextStyle(
                                        color: HexColor('#dd2634'),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          )),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: HomeCubit.profileModel == null
                                    ? Icon(Icons.error, size: 25)
                                    : CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error, size: 25),
                                        imageUrl: HomeCubit
                                            .profileModel!.data!.phone
                                            .toString(),
                                      )),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              CacheHelper.deleteData(key: 'uid');
                              CacheHelper.deleteData(key: 'email');
                              CacheHelper.deleteData(key: 'token');
                              if (CacheHelper.getData(key: 'socialToken') !=
                                  null) {
                                CacheHelper.deleteData(key: 'socialToken');
                              }
                              NavigateTo(context, LoginScreen());
                            },
                            icon: const Icon(Icons.logout,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
            );
          });
    }
  }
}
