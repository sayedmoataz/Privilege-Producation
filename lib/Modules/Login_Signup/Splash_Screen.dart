// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../Home_Pages/home_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Declare your method channel varibale here

  @override
  void initState() {
    //disableCapture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: HomePage(),
      text: 'Privilege',
      backgroundColor: Colors.white,
      imageSize: 130,
      imageSrc: "assets/1.png",
      duration: 5000,
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(fontSize: 30.0, color: HexColor('#0029e7')),
    );
  }
}
