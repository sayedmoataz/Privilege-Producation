// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Shared/UI/components.dart';
import '../../cubit/cubit.dart';
import '../../cubit/states.dart';

class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

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
                  title: cubit.isEnglish ? 'Languages' : 'اللغات'),
              body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/5.png'),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        cubit.isEnglish
                            ? 'Select Your Perable Language'
                            : "أختر لغتك المفضلة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#0029e7')),
                      ),
                      Text(
                        cubit.isEnglish
                            ? 'English is Default'
                            : "اللغة الإنجليزية هي اللغة الإفتراضية",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.normal,
                            color: HexColor('#616363')),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      cubit.isEnglish
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                    onPressed: null,
                                    child: Text(
                                      cubit.isEnglish
                                          ? 'English'
                                          : 'اللغة الإنجليزية',
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#616363')),
                                    ))
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                    onPressed: () {
                                      cubit.changeLanguage();
                                    },
                                    child: Text(
                                      cubit.isEnglish
                                          ? 'اللغة الإنجليزية'
                                          : 'English',
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#0029e7')),
                                    ))
                              ],
                            ),
                      cubit.isEnglish
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                    onPressed: () {
                                      cubit.changeLanguage();
                                    },
                                    child: Text(
                                      cubit.isEnglish
                                          ? 'اللغة العربية'
                                          : 'Arabic',
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#0029e7')),
                                    ))
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                    onPressed: null,
                                    child: Text(
                                      cubit.isEnglish
                                          ? 'Arabic'
                                          : 'اللغة العربية',
                                      style: TextStyle(
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#616363')),
                                    ))
                              ],
                            ),
                    ]),
              ),
            ),
          );
        });
  }
}
