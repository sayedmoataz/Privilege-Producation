import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/UI/components.dart';
import 'colg_levels.dart';

class UniversityColleges extends StatelessWidget {
  const UniversityColleges({Key? key}) : super(key: key);

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
                  title: cubit.isEnglish ? 'Colleges' : 'الكليات'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: cubit.oneUniversityModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                      color: HexColor('#0029e7'),
                    ))
                  : cubit.oneUniversityModel!.data!.colleges.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.school,
                                size: 200, color: HexColor('#0029e7')),
                            FittedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.isEnglish
                                    ? 'No Colleges available In This University'
                                    : 'لا يوجد كليات متاحة في هذه الجامعه',
                                style: TextStyle(
                                    fontSize: 40, color: HexColor('#dd2634')),
                              ),
                            ))
                          ],
                        ))
                      : GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            cubit.oneUniversityModel!.data!.colleges.length,
                            (index) => buildCollegeItem(index, () {
                              cubit.getOneCollege(cubit
                                  .oneUniversityModel!.data!.colleges[index].id
                                  .toString());
                              NavigateTo(context, ColleageLevels(index: index));
                            }, context, cubit),
                          )),
            ),
          );
        });
  }

  Widget buildCollegeItem(int index, VoidCallback buttonAction,
      BuildContext context, HomeCubit cubit) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
            onTap: buttonAction,
            child: Column(children: [
              const SizedBox(height: 10),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 60, color: HexColor('#616363')),
                    imageUrl: cubit
                        .oneUniversityModel!.data!.colleges[index].photo
                        .toString(),
                    height: MediaQuery.of(context).size.height * .20,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * .40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                    cubit.oneUniversityModel!.data!.colleges[index].name
                        .toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: HexColor('#0029e7'))),
              ),
            ])));
  }
}
