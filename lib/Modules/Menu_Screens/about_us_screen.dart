// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/UI/components.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

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
                  title: cubit.isEnglish ? 'About Us' : 'من نحن؟'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(data: cubit.aboutUsModel!.data!.about)),
            ),
          );
        });
  }
}
