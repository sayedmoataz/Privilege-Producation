import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '/Modules/content_modules/cources.dart';
import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../../Shared/UI/components.dart';

class ColleageLevels extends StatelessWidget {
  const ColleageLevels({Key? key, required this.index}) : super(key: key);
  final int index;

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
                  title: cubit.isEnglish ? "Levels" : 'المستويات'),
              drawer: CustomDrawer(isEnglish: cubit.isEnglish),
              body: cubit.oneCollegesModel == null
                  ? Center(
                      child: CircularProgressIndicator(
                        color: HexColor('#0029e7'),
                      ),
                    )
                  : cubit.oneCollegesModel!.data!.levels.isEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school,
                              size: 200,
                              color: HexColor('#0029e7'),
                            ),
                            FittedBox(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.isEnglish
                                    ? 'No Levels Available In This College'
                                    : "لا يوجد مستويات داخل هذه الكلية",
                                style: TextStyle(
                                    fontSize: 40, color: HexColor('#dd2634')),
                              ),
                            ))
                          ],
                        ))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomScrollView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) => buildPlaceItem(
                                      index,
                                      context,
                                      cubit.oneCollegesModel!.data!.photo
                                              .toString() ??
                                          'https://th.bing.com/th/id/R.e10262585addf11fa80aa77e6210a931?rik=%2fVpDaX3%2fMyMGDA&pid=ImgRaw&r=0',
                                      cubit.oneCollegesModel!.data!
                                          .levels[index].name
                                          .toString(),
                                      cubit.oneCollegesModel!.data!.name
                                          .toString(), () {
                                    cubit
                                        .getOneLevel(cubit.oneCollegesModel!
                                            .data!.levels[index].id
                                            .toString())
                                        .then((value) {
                                      NavigateTo(context, const Courses());
                                    });
                                  }, 1),
                                  childCount: cubit
                                      .oneCollegesModel!.data!.levels.length,
                                ),
                              ),
                            ],
                          ),
                        )),
        );
      },
    );
  }

  Widget buildPlaceItem(int index, BuildContext context, String image,
      String title, String fact, VoidCallback onTap, double? elevation) {
    return InkWell(
      onTap: onTap,
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
                          child: CachedNetworkImage(
                            progressIndicatorBuilder: (context, s, p) =>
                                const Padding(
                              padding: EdgeInsets.all(18.0),
                            ),
                            errorWidget: (context, string, dynamic) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/images/about_us/info(1)@3x.png'),
                            ),
                            imageUrl: image,
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
                          title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          fact,
                          style: TextStyle(
                              fontSize: 16, color: HexColor("#484848")),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
