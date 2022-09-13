// ignore_for_file: must_be_immutable, non_constant_identifier_names, unnecessary_brace_in_string_interps, unrelated_type_equality_checks, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PostCardHorizontalScreen extends StatelessWidget {
  PostCardHorizontalScreen(
      {Key? key,
      required this.UniversityName,
      required this.URLUniversityimage,
      required this.buttonaction,
      this.title})
      : super(key: key);

  String URLUniversityimage;
  String UniversityName;
  String? title;
  VoidCallback? buttonaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
            onTap: buttonaction,
            child: Column(children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error, size: 60, color: HexColor('#616363')),
                    imageUrl: URLUniversityimage,
                    height: MediaQuery.of(context).size.height * .20,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .40,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(UniversityName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: HexColor('#0029e7'))),
              ),
            ])));

    /*InkWell(
      onTap: buttonaction,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: ConditionalBuilder(
                condition: Image.network(
                  URLUniversityimage, fit: BoxFit.fill,
                  width: double.infinity, height: 200,
                ) 
                != Null,
                builder: (context) => CachedNetworkImage(
                  errorWidget: (context, url, error) => Icon(Icons.error,size: 60 , color: HexColor('#616363')),
                  imageUrl: URLUniversityimage,
                  height: 200,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                fallback: (context) => CircularProgressIndicator(color:HexColor('#0029e7') ,),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                UniversityName,
                maxLines: 2 ,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: HexColor('#0029e7')),
                /*Row(
                    children: [
                      Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Text(
                          '${NoOfFaculties} ${title}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: HexColor('#616363'),
                          ),
                        ),
                      ),
                    ],
                  ),*/
              )
            ),
          ],
        ),
      ),
    );*/
  }
}
