import 'package:chat_firebase/presentation/profile/components/me_item.dart';
import 'package:chat_firebase/presentation/profile/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/config/values/colors.dart';
import '../../app/utils/widgets/app.dart';
import 'components/head_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) => !controller.isLoading
            ? controller.meListItem.isEmpty
                ? const Center(child: Text('No Data'))
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.w, horizontal: 0.w),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 0.w, horizontal: 0.w),
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
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
