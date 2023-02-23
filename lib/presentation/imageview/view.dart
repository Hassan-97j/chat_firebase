import 'package:chat_firebase/app/config/values/values.dart';
import 'package:chat_firebase/presentation/imageview/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewPage extends GetView<ImageViewController> {
  const ImageViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageViewController>(
      init: ImageViewController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 2.0,
              decoration: const BoxDecoration(
                color: AppColors.secondaryElement,
              ),
            ),
          ),
          title: Text(
            'PhotoView',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: PhotoView(
          imageProvider: NetworkImage(controller.url),
        ),
      ),
    );
  }
}
