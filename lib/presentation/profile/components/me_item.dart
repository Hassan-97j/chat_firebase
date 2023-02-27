// ignore_for_file: must_be_immutable

import 'package:chat_firebase/app/config/app_config.dart/app_paddings.dart';
import 'package:chat_firebase/app/config/app_config.dart/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      margin: AppPAdding.bottom12,
      padding: AppPAdding.horizontal15,
      height: 60,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.tertiary,
      ),
      child: InkWell(
        onTap: ontap,
        child: Row(
          children: [
            SizedBox(
              height: 56,
              child: Image(
                image: AssetImage(assetName),
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              name,
              style: AppTextStyles.surface16TextStyle,
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: Get.theme.colorScheme.onTertiary,
              size: 29,
            )
          ],
        ),
      ),
    );
  }
}
