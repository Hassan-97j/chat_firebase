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
      body: Obx(
        () => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
              sliver: SliverToBoxAdapter(
                child: controller.headerDetails.value == null
                    ? Container()
                    : HeadItem(
                        url: controller.headerDetails.value?.photoUrl ??
                            "",
                        name:
                            controller.headerDetails.value?.displayName ??
                                "",
                        id: controller.headerDetails.value?.accessToken ??
                            "",
                      ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
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
        ),
      ),
    );
  }
}
