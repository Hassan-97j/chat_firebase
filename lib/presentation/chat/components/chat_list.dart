import 'package:chat_firebase/app/config/app_config.dart/app_paddings.dart';
import 'package:chat_firebase/presentation/chat/components/chat_items.dart';
import 'package:chat_firebase/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      init: ChatController(),
      builder: (_) => Container(
        padding: AppPAdding.bottom50,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.secondary,
        ),
        child: CustomScrollView(
          reverse: true,
          controller: controller.msgScrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.zero,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.msgContentList[index];
                    return ChatItem(
                      data: item.content ?? '',
                      type: item.type ?? '',
                      mainAxisAlignment: controller.userId == item.uid
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      color: controller.userId == item.uid
                          ? Get.theme.colorScheme.tertiary
                          : Get.theme.colorScheme.primaryContainer,
                      ontap: item.type == 'text'
                          ? null
                          : () {
                              Get.toNamed(
                                AppRoutes.photoimgview,
                                arguments: {
                                  "url": item.content ?? '',
                                },
                              );
                            },
                    );
                  },
                  childCount: controller.msgContentList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
