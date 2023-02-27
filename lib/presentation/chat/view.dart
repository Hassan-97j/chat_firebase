import 'package:chat_firebase/app/config/app_config.dart/app_paddings.dart';
import 'package:chat_firebase/presentation/chat/controller.dart';

import '../../app/utils/components/image.dart';
import 'components/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  void showPicker(context) {
    Get.bottomSheet(
      SafeArea(
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
      ),
    );
    // showModalBottomSheet(
    //   context: context,
    //   builder: (BuildContext bc) {
    //     return SafeArea(
    //       child: Wrap(
    //         children: [
    //           ListTile(
    //             leading: const Icon(Icons.photo_library),
    //             title: const Text('Gallery'),
    //             onTap: () async {
    //               await controller.imageFromGallery();
    //               Get.back();
    //               await controller.uploadFile();
    //             },
    //           ),
    //           ListTile(
    //             leading: const Icon(Icons.photo_camera),
    //             title: const Text('Camera'),
    //             onTap: () async {
    //               await controller.imageFromCamera();
    //               Get.back();
    //               controller.uploadFile();
    //             },
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
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
            flexibleSpace: Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
              ),
            ),
            title: Container(
              padding: EdgeInsets.zero,
              child: Row(children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: InkWell(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 28,
                      child: MyNetworkImage(
                        imgUrl: controller.toAvatar,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  width: 180,
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180,
                        height: 44,
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
                                  color: Get.theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                controller.toLocation,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Get.theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
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
                    bottom: 0,
                    height: 50,
                    child: Container(
                      width: 360,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: AppPAdding.left10bottom5,
                            width: 217,
                            height: 50,
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
                            height: 30,
                            width: 30,
                            margin: AppPAdding.left5,
                            child: GestureDetector(
                              onTap: () {
                                showPicker(context);
                              },
                              child: Icon(
                                Icons.photo_outlined,
                                size: 35,
                                color: Get.theme.colorScheme.surface,
                              ),
                            ),
                          ),
                          Container(
                            margin: AppPAdding.left10TB5,
                            // EdgeInsets.only(
                            //     left: 10.w, top: 5.h, bottom: 5.h),
                            width: 65,
                            height: 35,
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
