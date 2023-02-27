import 'package:chat_firebase/presentation/imageview/controller.dart';
import 'package:flutter/material.dart';
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
          title: const Text('Photo View'),
        ),
        body: PhotoView(
          imageProvider: NetworkImage(controller.url),
        ),
      ),
    );
  }
}
