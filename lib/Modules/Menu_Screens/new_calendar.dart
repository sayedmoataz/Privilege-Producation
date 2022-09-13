// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:privilege/cubit/cubit.dart';
import 'package:privilege/cubit/states.dart';

import '../../Shared/UI/calendar.dart';
import '../../Shared/UI/components.dart';
import '../../Shared/local/cache_helper.dart';
import '../Login_Signup/login_screen.dart';

class MyCalendar extends StatelessWidget {
  MyCalendar({Key? key}) : super(key: key);
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection:
              cubit.isEnglish ? TextDirection.ltr : TextDirection.rtl,
          child: CacheHelper.getData(key: 'token') == null
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar: myappbar(
                      context: context,
                      title:
                          cubit.isEnglish ? 'Your Calendar' : 'تقويمك الدراسي'),
                  body: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.asset(
                              'assets/1.png',
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              cubit.isEnglish
                                  ? 'Please Login to see your  courses'
                                  : 'يرجى تسجيل الدخول لمشاهدة دوراتك',
                              style: TextStyle(
                                  fontSize: 25, color: HexColor('#616363')),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: HexColor('#0029e7'),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              cubit.isEnglish
                                  ? 'Login Now '
                                  : 'تسجيل الدخول الآن',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: myappbar(
                      context: context,
                      title:
                          cubit.isEnglish ? 'Your Calendar' : 'تقويمك الدراسي'),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        calendar(foucsedDay: cubit.foucsedDay),
                        cubit.mytasks.isEmpty
                            ? Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 15),
                                child: const Text("No events",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            : Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 15),
                                child: const Text("Your Events",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.mytasks.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                  "Task : ${(cubit.mytasks[index])['title'].toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 21,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                  "Time : ${(cubit.mytasks[index])['date'].toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.red),
                                            onPressed: () {
                                              cubit.deleteRow(
                                                  id: (cubit
                                                      .mytasks[index])['id']);
                                            }),
                                      ],
                                    )));
                          },
                        ),
                        const SizedBox(height: 60)
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: HexColor('#0029e7'),
                    onPressed: () {
                      var contentTitle = TextFormField(
                        controller: titleController,
                        autofocus: true,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Workout Name',
                        ),
                      );
                      var contentDate = TextFormField(
                        controller: dateController,
                        autofocus: true,
                        keyboardType: TextInputType.datetime,
                        decoration:
                            const InputDecoration(labelText: 'Workout date'),
                      );
                      var btn = FlatButton(
                        child: const Text('Save'),
                        onPressed: () {
                          cubit.insertToDatabase(
                              title: titleController.text.toString(),
                              date: dateController.text.toString());
                          Navigator.of(context).pop(false);
                        },
                      );
                      var cancelButton = FlatButton(
                          child: const Text('Cancel'),
                          onPressed: () => Navigator.of(context).pop(false));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 10.0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  // To make the card compact
                                  children: <Widget>[
                                    const SizedBox(height: 16.0),
                                    const Text("Reminder Your study Hours"),
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        child: contentTitle),
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        child: contentDate),
                                    Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[btn, cancelButton]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
        );
      },
    );
  }
}
