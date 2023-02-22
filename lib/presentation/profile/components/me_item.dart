// ignore_for_file: must_be_immutable

import 'package:chat_firebase/app/config/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MeItem extends StatelessWidget {
  MeItem({
    required this.assetName,
    required this.name,
    this.ontap,
    super.key,
  });
  String assetName;
  String name;
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.w),
      padding: EdgeInsets.only(top: 0.w, left: 15.w, right: 15.w),
      height: 56.w,
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
      ),
      child: InkWell(
        onTap: ontap,//() {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 56.w,
                  child: Image(
                    image: AssetImage(assetName),
                    height: 40.w,
                    width: 40.w,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 14.w,
                  ),
                  height: 56.w,
                  child: Text(
                    name,
                    style: TextStyle(
                      color: AppColors.thirdElement,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image(
                    image: const AssetImage('assets/icons/ang.png'),
                    height: 15.w,
                    width: 15.w,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
