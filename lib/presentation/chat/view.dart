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
      backgroundColor: Get.theme.colorScheme.secondary,
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
              padding: AppPAdding.bottom12,
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
          body: Column(
            children: [
              const Expanded(child: ChatList()),
              Container(
                padding: AppPAdding.vert10hor15,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.tertiary,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: Get.width * 0.70,
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: controller.textController,
                          autofocus: false,
                          focusNode: controller.contentNode,
                          decoration: const InputDecoration(
                            hintText: "SendMessage",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {
                          showPicker(context);
                        },
                        icon: Icon(
                          Icons.photo_outlined,
                          size: 35,
                          color: Get.theme.colorScheme.surface,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () async {
                            await controller.sendMessage();
                            await controller.sendPushNotification(
                              controller.toToken,
                              controller.textController.text.trim(),
                              controller.toAvatar,
                            );
                          },
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Text('Send'),
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
