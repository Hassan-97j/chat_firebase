// ignore_for_file: must_be_immutable

import 'package:chat_firebase/app/config/values/values.dart';
import 'package:chat_firebase/app/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadItem extends StatelessWidget {
  HeadItem({
    required this.url,
    required this.name,
    required this.id,
    super.key,
  });

  String url;
  String name;
  String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 30.w, left: 15.w, right: 15.w, bottom: 15.w),
      margin: EdgeInsets.only(bottom: 30.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        boxShadow: const [
          BoxShadow(
            color: AppColors.tabCellSeparator,
            offset: Offset(0.0, 5.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 54.w,
                  width: 54.w,
                  child: netImageCached(
                    url,
                    width: 54.w,
                    height: 54.w,
                  ),
                ),
              ),
              // SizedBox(
              //   width: 250.w,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Container(
              //         padding: EdgeInsets.only(
              //             top: 5.w, left: 15.w, right: 0.w, bottom: 0.w),
              //         alignment: Alignment.centerLeft,
              //         width: 190.w,
              //         height: 54.w,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               name,
              //               overflow: TextOverflow.clip,
              //               style: TextStyle(
              //                 fontSize: 15.sp,
              //                 fontWeight: FontWeight.bold,
              //                 color: AppColors.thirdElement,
              //               ),
              //             ),
              //             Text(
              //               id,
              //               overflow: TextOverflow.clip,
              //               style: TextStyle(
              //                 fontSize: 13.sp,
              //                 fontWeight: FontWeight.normal,
              //                 color: AppColors.thirdElementText,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
          SizedBox(
            width: 250.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 5.w, left: 15.w, right: 0.w, bottom: 0.w),
                  alignment: Alignment.centerLeft,
                  width: 190.w,
                  height: 54.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.thirdElement,
                        ),
                      ),
                      Text(
                        id,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColors.thirdElementText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
