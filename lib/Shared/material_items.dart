import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/cubit/cubit.dart';

import 'local/cache_helper.dart';

Widget buildMaterialItem(
    HomeCubit model,
    int index,
    BuildContext context,
    String title,
    String fact,
    bool cond1,
    bool cond2,
    String NOView,
    Widget widget,
    double? elevation) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Card(
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        fact,
                        style:
                            TextStyle(fontSize: 14, color: HexColor("#484848")),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (Platform.isAndroid)
                        if (model.aboutUsModel!.check != false )
                          if (CacheHelper.getData(key: 'token') != null)
                            if (model.oneCourseModel!.data!.materials[index].viewNumber! >= 1)
                            Text(
                              NOView,
                              style: TextStyle(
                                  fontSize: 16, color: HexColor('#dd2634')),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      if (Platform.isIOS)
                        if (model.aboutUsModel!.check != false )
                          if (CacheHelper.getData(key: 'token') != null)
                            if (model.oneCourseModel!.data!.materials[index].viewNumber! >= 1)
                              Text(
                                NOView,
                                style: TextStyle(
                                    fontSize: 14, color: HexColor('#dd2634')),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                    ],
                  ),
                ),
              ),
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
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: widget)),
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
