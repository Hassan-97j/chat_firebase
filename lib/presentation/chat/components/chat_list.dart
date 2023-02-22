import 'package:chat_firebase/presentation/chat/components/chat_left_items.dart';
import 'package:chat_firebase/routes/routes.dart';
import 'package:chat_firebase/app/config/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'chat_right_items.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.only(bottom: 50.h),
        decoration: const BoxDecoration(color: AppColors.chatbg),
        child: CustomScrollView(
          reverse: true,
          controller: controller.msgScrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.msgContentList[index];
                    if (controller.userId == item.uid) {
                      return ChatRightItem(
                        data: item.content ?? "",
                        type: item.type ?? "",
                        ontap: () {
                          Get.toNamed(
                            AppRoutes.photoimgview,
                            arguments: {
                              "url": item.content ?? '',
                            },
                          );
                        },
                      );
                    }
                    return ChatLeftItem(
                      data: item.content ?? "",
                      type: item.type ?? "",
                      ontap: () {
                        Get.toNamed(
                          AppRoutes.photoimgview,
                          arguments: {
                            "url": item.content ?? '',
                          },
                        );
                      },
                    );
                  },
                  childCount: controller.state.msgContentList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
