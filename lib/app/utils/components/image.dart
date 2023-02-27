// ignore_for_file: must_be_immutable

import 'package:chat_firebase/app/config/app_config.dart/ap_borders.dart';
import 'package:chat_firebase/app/config/app_config.dart/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyNetworkImage extends StatelessWidget {
  MyNetworkImage({required this.imgUrl, this.width, this.height, super.key});
  String imgUrl;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.circ35BRG,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image(
        image: AssetImage(AppAssets.launchIcon),
      ),
    );
  }
}
