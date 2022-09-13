// ignore_for_file: non_constant_identifier_names, use_function_type_syntax_for_parameters, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Modules/Home_Pages/home_page.dart';
import 'package:privilege/Modules/Menu_Screens/languages.dart';
import 'package:privilege/Shared/UI/components.dart';

import '/Modules/Menu_Screens/Notification_Screen.dart';
import '/Modules/Menu_Screens/about_us_screen.dart';
import '/Modules/Menu_Screens/contact_us_screen.dart';
import '/Modules/Menu_Screens/my_favorite_screen.dart';
import '/Modules/Settings/Setting_Screen.dart';
import '/Shared/UI/Drawer/bottom_user_info.dart';
import '/Shared/UI/Drawer/custom_list_tile.dart';
import '/Shared/UI/Drawer/header.dart';
import '../../../Modules/Menu_Screens/my_courses_screen.dart';
import '../../../Modules/Menu_Screens/new_calendar.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key, required this.isEnglish}) : super(key: key);
  final bool isEnglish;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final bool _isCollapsed = true;

  // Declare your method channel varibale here

  @override
  void initState() {
    // this method to user can't take screenshot your application

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              Divider(color: HexColor('#616363')),
              // home page
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.home,
                title: widget.isEnglish ? 'Home Page' : 'الصفحة الرئيسية',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const HomePage());
                },
              ),
              const SizedBox(height: 20.0),
              // favouirte
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.favorite,
                title: widget.isEnglish ? 'My Favourites' : 'المفضلة',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const MyFavoriteScreen());
                },
              ),
              const SizedBox(height: 20.0),
              // courses
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.local_library_sharp,
                title: widget.isEnglish ? 'My Courses' : 'كورساتي',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const MyCoursesScreen());
                },
              ),
              const SizedBox(height: 20.0),
              // courses
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.calendar_month,
                title: widget.isEnglish ? 'Calendar' : 'التقويم',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, MyCalendar());
                },
              ),
              const SizedBox(height: 20.0),
              // contact us
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.message,
                title: widget.isEnglish ? 'Contact Us' : 'تواصل معنا',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const ContactUsScreen());
                },
              ),
              const SizedBox(height: 20.0),
              // contact us
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.language,
                title: widget.isEnglish ? 'Languages' : 'اللغات',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const Language());
                },
              ),
              const SizedBox(height: 20.0),
              // about us
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.info,
                title: widget.isEnglish ? 'About us' : 'من نحن؟',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, const AboutUsScreen());
                },
              ),
              const SizedBox(height: 20.0),
              //const Divider(color: Colors.grey),
              //const Spacer(),
              // edit profile
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.settings,
                title:
                    widget.isEnglish ? 'update profile' : 'تعديل الملف الشخصي',
                infoCount: 0,
                OnTab: () {
                  NavigateTo(context, SettingsScreen());
                },
              ),
              Divider(color: HexColor('#616363')),
              const SizedBox(height: 5),
              BottomUserInfo(
                  isCollapsed: _isCollapsed, isEnglish: widget.isEnglish),
              /*Align(
                  alignment: _isCollapsed
                  ? Alignment.bottomRight
                  : Alignment.bottomCenter,
                  child: IconButton(
                    splashColor: Colors.transparent,
                    icon: Icon(
                      _isCollapsed
                      ? Icons.arrow_back_ios
                      : Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
                ),*/
            ],
          ),
        )),
      ),
    );
  }
}
