// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// // ignore: must_be_immutable
// class ChatLeftItem extends StatelessWidget {
//   ChatLeftItem({
//     required this.data,
//     this.ontap,
//     required this.type,
//     Key? key,
//   }) : super(key: key);

//   String data;
//   Function()? ontap;
//   String type;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//           EdgeInsets.only(top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: 230.w, minHeight: 40.w),
//             child: Container(
//               margin: EdgeInsets.only(right: 10.w, top: 0.w),
//               padding: EdgeInsets.only(
//                   top: 10.w, left: 15.w, right: 15.w, bottom: 10.w),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 176, 106, 231),
//                     Color.fromARGB(255, 166, 112, 231),
//                     Color.fromARGB(255, 131, 123, 231),
//                     Color.fromARGB(255, 104, 132, 231),
//                   ],
//                   transform: GradientRotation(90),
//                 ),
//                 borderRadius: BorderRadius.circular(10.w),
//               ),
//               // ignore: unrelated_type_equality_checks
//               child: type == "text"
//                   ? Text(data)
//                   : ConstrainedBox(
//                       constraints: BoxConstraints(
//                         maxWidth: 90.w,
//                       ),
//                       child: GestureDetector(
//                         onTap: ontap,
//                         child: CachedNetworkImage(imageUrl: data),
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
