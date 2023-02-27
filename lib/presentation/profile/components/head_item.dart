// ignore_for_file: must_be_immutable
import 'package:chat_firebase/app/config/app_config.dart/app_paddings.dart';
import 'package:chat_firebase/app/config/app_config.dart/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/utils/components/image.dart';


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
      padding: AppPAdding.top30LRB15,
      margin: AppPAdding.bottom30,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.secondary,
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.outline,
            offset: const Offset(0.0, 5.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            child: MyNetworkImage(
              imgUrl: url,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                overflow: TextOverflow.clip,
                style: AppTextStyles.surface16TextStyle,
              ),
              Text(
                id,
                overflow: TextOverflow.clip,
                style: AppTextStyles.onTertiary14TextStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
