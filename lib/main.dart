import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/Shared/UI/components.dart';

import 'Modules/Login_Signup/Splash_Screen.dart';
import 'Modules/Login_Signup/offline.dart';
import 'Modules/Menu_Screens/Notification_Screen.dart';
import 'Shared/disable_screen_record.dart';
import 'Shared/global.dart';
import 'Shared/https_client.dart';
import 'Shared/local/cache_helper.dart';
import 'cubit/cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  BuildContext globalContext = Global.materialKey.currentContext!;
  NavigateTo(globalContext, const NotificationScreen());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  disableCapture();
  await CacheHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      msg: "there is an update of notifications go and check it",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    BuildContext globalContext = Global.materialKey.currentContext!;
    NavigateTo(globalContext, const NotificationScreen());
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HomeCubit()
          ..getFavoritesCourses()
          ..getAllUniversities()
          ..getAllNotifications()
          ..getProfileData()
          ..getUserCourses()
          ..getUserArray()
          ..aboutUs()
          ..createDataBase(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Privilege",
          color: HexColor('#0029e7'),
          routes: {"notification": (_) => const NotificationScreen()},
          home: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return const WelcomeScreen();
              } else {
                return const OfflineWidget();
              }
            },
            child: Center(
                child: CircularProgressIndicator(
              color: HexColor('#0029e7'),
            )),
          ),
        ));
  }
}
