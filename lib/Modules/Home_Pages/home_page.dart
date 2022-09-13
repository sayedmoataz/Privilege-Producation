import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/content_modules/university_colleges.dart';
import '/Shared/UI/Cards/post_card_horizontal.dart';
import '/Shared/UI/Drawer/custom_drawer.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                context: context, title: cubit.isEnglish ? 'Home' : 'الرئيسية'),
            drawer: CustomDrawer(isEnglish: cubit.isEnglish),
            body: cubit.allUniversitiesModel == null
                ? Center(
                    child:
                        CircularProgressIndicator(color: HexColor('#0029e7')))
                : Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.getAllUniversities();
                      },
                      child: GridView.count(
                          crossAxisCount: 2,
                          padding: const EdgeInsets.all(5),
                          clipBehavior: Clip.antiAlias,
                          children: List.generate(
                            cubit.allUniversitiesModel!.data.length,
                            (index) => PostCardHorizontalScreen(
                              URLUniversityimage: cubit
                                  .allUniversitiesModel!.data[index].photo!,
                              UniversityName:
                                  cubit.allUniversitiesModel!.data[index].name!,
                              buttonaction: () {
                                cubit
                                    .getOneUniversity(cubit
                                        .allUniversitiesModel!.data[index].id
                                        .toString())
                                    .then((value) {
                                  NavigateTo(
                                      context, const UniversityColleges());
                                });
                              },
                            ),
                          )),

                      /*ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: cubit.allUniversitiesModel!.data.length,
                  itemBuilder: (context, index)
                    => PostCardHorizontalScreen(
                      URLUniversityimage: cubit.allUniversitiesModel!.data[index].photo!,
                      UniversityName:cubit.allUniversitiesModel!.data[index].name!,
                      buttonaction: () {
                        cubit.getOneUniversity(
                          cubit.allUniversitiesModel!.data[index].id.toString()).then(
                            (value) {
                              NavigateTo(context, const UniversityColleges());
                            }
                          );
                      },
                    ),
                )*/
                    ),
                  ),
          ),
        );
      },
    );
  }
}
