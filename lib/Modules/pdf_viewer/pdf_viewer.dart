// ignore_for_file: avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  const PdfViewer({Key? key, required this.pdfUrl}) : super(key: key);
  final String pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: SfPdfViewer.network(
            pdfUrl,
            password: "syncfusion",
          ),
        ),
      ],
    ));
  }
}
