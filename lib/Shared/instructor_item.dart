import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget buildInstructorItem(BuildContext context, String image, String title,
    String fact, VoidCallback onTap, double? elevation) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Card(
        elevation: elevation,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          width: double.infinity,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, s, p) =>
                              const Padding(
                            padding: EdgeInsets.all(18.0),
                          ),
                          errorWidget: (context, string, dynamic) => Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.network(
                                "https://th.bing.com/th/id/OIP.vilyDbobpd8pFwCuiHRSWAHaIG?pid=ImgDet&rs=1"),
                          ),
                          imageUrl: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      /*Text(
                        fact,
                        style: TextStyle(
                            fontSize: 16, color: HexColor("#484848")),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
