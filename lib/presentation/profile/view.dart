import 'package:chat_firebase/app/config/app_config.dart/app_textstyle.dart';
import 'package:chat_firebase/presentation/profile/components/me_item.dart';
import 'package:chat_firebase/presentation/profile/controller.dart';
import 'components/head_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) => !controller.isLoading
            ? controller.meListItem.isEmpty
                ? Center(
                    child: Text(
                      'No Data',
                      style: AppTextStyles.onpPrimary26TextStyle,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverToBoxAdapter(
                          child: controller.headerDetails == null
                              ? Container()
                              : HeadItem(
                                  url: controller.headerDetails?.photoUrl ?? "",
                                  name: controller.headerDetails?.displayName ??
                                      "",
                                  id: controller.headerDetails?.accessToken ??
                                      "",
                                ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var item = controller.meListItem[index];
                              return MeItem(
                                assetName: item.icon ?? "",
                                name: item.name ?? "",
                                ontap: () {
                                  if (item.route == '/logout') {
                                    controller.onLogOut();
                                  }
                                },
                              );
                            },
                            childCount: controller.meListItem.length,
                          ),
                        ),
                      ),
                    ],
                  )
            : Center(
                child: CircularProgressIndicator(
                color: Get.theme.colorScheme.surface,
              )),
      ),
    );
  }
}
