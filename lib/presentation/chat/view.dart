import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_firebase/app/config/values/values.dart';
import 'package:chat_firebase/presentation/chat/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  void showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  await controller.imageFromGallery();
                  Get.back();
                  await controller.uploadFile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  await controller.imageFromCamera();
                  Get.back();
                  controller.uploadFile();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope?.unfocus();
      },
      child: GetBuilder<ChatController>(
        init: ChatController(),
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 176, 106, 231),
                    Color.fromARGB(255, 166, 112, 231),
                    Color.fromARGB(255, 131, 123, 231),
                    Color.fromARGB(255, 104, 132, 231),
                  ],
                  transform: GradientRotation(90),
                ),
              ),
            ),
            title: Container(
              padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
              child: Row(children: [
                Container(
                  padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
                  child: InkWell(
                    onTap: () {},
                    child: SizedBox(
                      width: 44.w,
                      height: 44.w,
                      child: CachedNetworkImage(
                        imageUrl: controller.toAvatar,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: null,
                          height: 44.w,
                          width: 44.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Image(
                          image: AssetImage('assets/images/ic_launcher.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                Container(
                  width: 180.w,
                  padding: EdgeInsets.only(top: 0.w, bottom: 0.w, right: 0.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180.w,
                        height: 44.w,
                        child: GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.toName,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primaryBackground,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              Text(
                                controller.toLocation,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  color: AppColors.primaryBackground,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          body: SafeArea(
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Stack(
                children: [
                  const ChatList(),
                  Positioned(
                    bottom: 0.h,
                    height: 50.h,
                    child: Container(
                      width: 360.h,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBackground,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10.w, bottom: 5.w),
                            width: 217.w,
                            height: 50.h,
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: controller.textController,
                              autofocus: false,
                              focusNode: controller.contentNode,
                              decoration: const InputDecoration(
                                hintText: "SendMessage",
                              ),
                            ),
                          ),
                          Container(
                            height: 30.h,
                            width: 30.w,
                            margin: EdgeInsets.only(left: 5.w),
                            child: GestureDetector(
                              onTap: () {
                                showPicker(context);
                              },
                              child: Icon(
                                Icons.photo_outlined,
                                size: 35.w,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10.w, top: 5.h, bottom: 5.h),
                            width: 65.w,
                            height: 35.h,
                            child: ElevatedButton(
                              onPressed: () async {
                                await controller.sendMessage();
                              },
                              child: const Text('send'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
