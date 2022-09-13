// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';

Widget calendar({
  required DateTime foucsedDay,
}) {
  return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(0.0, 5))
          ]),
      child: TableCalendar(
        firstDay: DateTime(2022, 07, 01),
        lastDay: DateTime(2023, 07, 31),
        focusedDay: foucsedDay,
        calendarStyle: CalendarStyle(
          canMarkersOverflow: false,
          markerDecoration: const BoxDecoration(color: Colors.black),
          weekendTextStyle: const TextStyle(color: Colors.red),
          todayDecoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          todayTextStyle: TextStyle(
              color: HexColor('#0029e7'),
              fontSize: 15,
              fontWeight: FontWeight.bold),
          selectedDecoration: BoxDecoration(color: HexColor('#dd2634')),
        ),
        //onDaySelected: _onDaySelected,
        //calendarController: _calendarController,
        // events: _events,

        headerStyle: HeaderStyle(
          leftChevronIcon:
              Icon(Icons.arrow_back_ios, size: 15, color: HexColor('#0029e7')),
          rightChevronIcon: Icon(Icons.arrow_forward_ios,
              size: 15, color: HexColor('#0029e7')),
          titleTextStyle:
              GoogleFonts.montserrat(color: HexColor('#0029e7'), fontSize: 16),
          formatButtonDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          formatButtonTextStyle: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ));
}
