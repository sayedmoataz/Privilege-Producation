// ignore_for_file: non_constant_identifier_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Modules/Menu_Screens/Notification_Screen.dart';
import '../../Modules/search/search.dart';
//import 'package:my_test_shop/shared/cubit/login_cubit/login_cubit.dart';

Widget MyTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? inputType,
  bool obsecure = false,
  String? hint,
  Widget? icon,
  int? length,
  int? lines,
  InputBorder? border = const OutlineInputBorder(),
}) =>
    TextFormField(
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      controller: controller,
      keyboardType: inputType,
      obscureText: obsecure,
      maxLength: length,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: icon,
        border: border,
        contentPadding: const EdgeInsets.all(20),
      ),
      validator: (Value) {
        return '$controller Must Not be Empty';
      },
    );

PreferredSizeWidget myappbar({context, title}) => AppBar(
      title: Text(title),
      backgroundColor: HexColor('#0029e7'),
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarColor: HexColor('#0029e7')),
      actions: [
        IconButton(
          onPressed: () {
            NavigateTo(context, const Search());
          },
          icon: const Icon(Icons.search),
          padding: const EdgeInsets.only(right: 10.0),
        ),
        IconButton(
          onPressed: () {
            NavigateTo(context, const NotificationScreen());
          },
          icon: const Icon(Icons.notifications_active),
          padding: const EdgeInsets.only(right: 10.0),
        ),
      ],
    );

void NavigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateFinalTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));
