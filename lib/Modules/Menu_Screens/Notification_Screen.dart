import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart' as intl;
import 'package:privilege/Modules/content_modules/one_course_screen.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/cubit/cubit.dart';
import '/cubit/states.dart';
import '/models/notifications_models/all_notification_model.dart';
import '../../Shared/UI/Drawer/custom_drawer.dart';
import '../search/search.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  Widget buildNotificationItem(Data model, BuildContext context, HomeCubit cubit) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (model.courseId != null) {
              cubit.getOneCourse(model.courseId.toString()).then((value) {
                if (cubit.userArrayModel!.data!.myCourses.contains(model.courseId)) {
                  cubit.checkCourseBought(true);
                } else {
                  cubit.checkCourseBought(false);
                }
                NavigateTo(context, OneCourseScreen());
              });
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                width: double.infinity,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: HexColor('#616363'))
                ),
                child: Row(
                  children: [
                    Image.asset('assets/2.png'),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            model.message.toString(),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, color: HexColor('#616363')),
                          ),
                          Text(
                            convertDateTimeDisplay(DateTime.parse(model.createdAt.toString()).toString()),
                            style: TextStyle(fontSize: 14, color: HexColor('#616363')),
                          ),
                        ],
                      ),
                    ),
                    if (model.courseId != null)
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: HexColor('#0029e7'),
                      ),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }

  convertDateTimeDisplay(String date) {
    final intl.DateFormat displayFormater = intl.DateFormat('yyyy-MM-dd HH:mm');
    final intl.DateFormat serverFormater = intl.DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        if (cubit.allNotificationsModel == null) {
          return Center(child: CircularProgressIndicator(color: HexColor('#0029e7')));
        } else {
          return cubit.allNotificationsModel!.data.isEmpty
            ? Directionality(
                textDirection: cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                  title: Text(cubit.isEnglish ? 'Notification' : 'الإشعارات'),
                  backgroundColor: HexColor('#0029e7'),
                  systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
                  actions: [
                    IconButton(
                      onPressed: () => NavigateTo(context, const Search()),
                      icon: const Icon(Icons.search),
                      padding: const EdgeInsets.only(right: 10.0),
                    ),
                  ],
                ),
                  drawer: CustomDrawer(isEnglish: cubit.isEnglish),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.notifications,size: 200,color: Colors.grey,),
                        FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cubit.isEnglish ? 'You Don\'t Have Any Notifications' : 'لا يوجد إشعارات',
                                style: const TextStyle(fontSize: 40, color: Colors.grey),
                            ),
                            )
                        )
                      ],
                    ),
                  ),
                )
            )
            : Directionality(
                textDirection: cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text( cubit.isEnglish ? 'Notification' : 'الإشعارات'),
                    backgroundColor: HexColor('#0029e7'),
                    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
                    actions: [
                      IconButton(
                        onPressed: () => NavigateTo(context, const Search()),
                        icon: const Icon(Icons.search),
                        padding: const EdgeInsets.only(right: 10.0),
                      ),
                    ],
                  ),
                  drawer: CustomDrawer(isEnglish: cubit.isEnglish),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                            cubit.allNotificationsModel!.data.length,
                            itemBuilder: (context, index) => buildNotificationItem(
                              cubit.allNotificationsModel!.data.reversed.toList()[index],
                              context,
                              cubit
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                )
            );
        }
      }
    );
  }
}