// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:privilege/Modules/Menu_Screens/Notification_Screen.dart';
import 'package:privilege/Modules/search/search.dart';

Widget englishAppBar(bool isHome, String title, BuildContext context) {
  return AppBar(
    title: Text(title),
    actions: isHome
        ? [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Search()));
              },
              icon: const Icon(Icons.search),
              padding: const EdgeInsets.only(right: 10.0),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()),
                );
              },
              icon: const Icon(Icons.notifications_active),
              padding: const EdgeInsets.only(right: 10.0),
            ),
          ]
        : [],
  );
}

Widget arabicAppBar(bool isHome, String title, BuildContext context) {
  return AppBar(
      title: Text(
        title,
        textDirection: TextDirection.rtl,
      ),
      leading: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Search()));
            },
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.only(right: 10.0),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationScreen()),
              );
            },
            icon: const Icon(Icons.notifications_active),
            padding: const EdgeInsets.only(right: 10.0),
          ),
        ],
      ));
}
