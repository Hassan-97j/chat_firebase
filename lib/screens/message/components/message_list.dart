import 'package:chat_firebase/screens/message/components/msg_list_item.dart';
import '../index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../common/utils/date.dart';

class MessageList extends GetView<MessageController> {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        header: const WaterDropHeader(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.msgList[index];
                    return MsgListItem(
                      imgUrl: item.data().from_uid == controller.token
                          ? item.data().to_avatar!
                          : item.data().from_avatar!,
                      name: item.data().from_uid == controller.token
                          ? item.data().to_name!
                          : item.data().from_name!,
                      lastMsg: item.data().last_msg ?? "",
                      lastTime: duTimeLineFormat(
                          (item.data().last_time as Timestamp).toDate()),
                      ontap: () {
                        var toUid = "";
                        var toName = "";
                        var toAvatar = "";
                        if (item.data().from_uid == controller.token) {
                          toUid = item.data().to_uid ?? "";
                          toName = item.data().to_name ?? "";
                          toAvatar = item.data().to_avatar ?? "";
                        } else {
                          toUid = item.data().from_uid ?? "";
                          toName = item.data().from_name ?? "";
                          toAvatar = item.data().from_avatar ?? "";
                        }
                        Get.toNamed(
                          '/chat',
                          arguments: {
                            "doc_id": item.id,
                            "to_uid": toUid,
                            "to_name": toName,
                            "to_avatar": toAvatar,
                          },
                        );
                      },
                    );
                  },
                  childCount: controller.state.msgList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
