// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_import, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:privilege/Shared/UI/components.dart';
import 'package:privilege/cubit/cubit.dart';

import '/Modules/pdf_viewer/pdf_viewer.dart';
import '/Modules/video_player/material.dart';
import '/models/courses_models/one_user_course.dart';
import '/models/materials/one_material_model.dart';

class LecturesScreen extends StatefulWidget {
  LecturesScreen(
      {Key? key,
      required this.material,
      this.comments,
      required this.courseId,
      this.myCubit})
      : super(key: key);
  final OneMaterialModel material;
  final myCubit;
final List<Comments>? comments;
  final String courseId;

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  // Declare your method channel varibale here

  @override
  void initState() {
    // this method to user can't take screenshot your application

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          buildLectureItem(widget.material, index),
      itemCount: 1,
    );
  }

  Widget buildLectureItem(OneMaterialModel model, int index) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    model.data!.name.toString(),
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                Spacer(),
                model.code == 205
                    ? FittedBox(
                        child: Text(
                        ' You can\'t watch this\n video again',
                        maxLines: 2,
                      ))
                    : widget.material.data!.viewNumber != 0
                        ? FittedBox(
                            child: Text(
                                'You can Watch it ${widget.material.data!.viewNumber.toString()} times'))
                        : Container()
              ],
            ),
            // if (model.allUniversitiesModel!.check == true)
            //  if (model.data!.video != null)
                /*InkWell(
                  onTap: () {
                    print(model.data!.video);
                    NavigateTo(
                        context,
                        PdfViewer(
                            pdfUrl: widget.material.data!.video.toString()));
                  },
                  child: Row(
                    children: const [
                      Text(
                        'pdf ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Icon(Icons.picture_as_pdf)
                    ],
                  ),
                ),*/
            // if (cubit.allUniversitiesModel!.check == false)
              if (model.data!.file != null)
                InkWell(
                  onTap: () {
                    print(model.data!.file);
                    NavigateTo(
                        context,
                        PdfViewer(
                            pdfUrl: widget.material.data!.file.toString()));
                  },
                  child: Row(
                    children: const [
                      Text(
                        'pdf ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Icon(Icons.picture_as_pdf)
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}
