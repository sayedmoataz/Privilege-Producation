// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/Modules/content_modules/cources.dart';
// import '/cubit/cubit.dart';
// import '/cubit/states.dart';
// import '/models/levels_models/one_level_model.dart';
//
// class Subjects extends StatelessWidget {
//   const Subjects({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var cubit = HomeCubit.get(context);
//           return Scaffold(
//             body:cubit.oneLevelModel==null?Center(child: CircularProgressIndicator(color:HexColor('#0029e7') ,),):  ListView.builder(
//               itemCount: cubit.oneLevelModel!.data!.subjects.length,
//                 itemBuilder:(context,index)=>
//                 buildCollegeItem(cubit.oneLevelModel!.data!,index,(){
//                   cubit.getOneSubjectCollege(cubit.oneLevelModel!.data!.subjects[index].id.toString());
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Courses()));
//                 })),
//           );
//         });
//   }
//   Widget buildCollegeItem(Data model,int index,VoidCallback buttonAction){
//     return InkWell(
//       onTap: buttonAction,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               // University Image
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Stack(
//                   children: [
//                     CachedNetworkImage(errorWidget: (context, url, error) => Icon(Icons.error,size: 60,),
//                       imageUrl:model.subjects[index].photo.toString(),height: 200,fit: BoxFit.cover,
//                       width: double.infinity, ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Container(height: 60,width: 50,
//                         child:  Padding(
//                         padding:
//                                 const EdgeInsets.symmetric(horizontal: 3.0),
//             // No. Faculties
//             child: Text(
//             'term\n ${model.subjects[index].term}',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//             color: Colors.white,
//             ),
//             ),
//             ),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 //     Image.network(
//                 //   ,
//                 //   height: 200,
//                 //   fit: BoxFit.contain,
//                 //   width: double.infinity,
//                 // ),
//               ),
//               Container(
//                   color: Colors.white10,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // University Name
//                             Padding(
//                               padding: const EdgeInsets.only(left: 3.0),
//                               child: Text(
//                                 model.subjects[index].name.toString(),
//                                 textAlign: TextAlign.center,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: const TextStyle(
//
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             // Faculaties And Students
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.symmetric(horizontal: 3.0),
//                                   // No. Faculties
//                                   child: Text(
//                                     '${model.subjects[index].coursesCount} courses',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 16,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//
//                                 // No. Student
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       // const Spacer(),
//                       // button
//                     ],
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// }
