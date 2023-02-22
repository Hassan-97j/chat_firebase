import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_firebase/app/config/values/values.dart';
import 'package:chat_firebase/presentation/contacts/controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactList extends GetView<ContactsController> {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.contactList.isEmpty
        ? Center(child: Text('nodata'))
        : GetBuilder(
            init: ContactsController(),
            builder: (_) => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var item = controller.contactList[index];
                        return Container(
                          padding: EdgeInsets.only(
                            top: 15.w,
                            left: 15.w,
                            right: 15.w,
                          ),
                          child: InkWell(
                            onTap: () {
                              if (item.id != null) {
                                controller.goChat(item);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 0.w,
                                    left: 0.w,
                                    right: 15.w,
                                  ),
                                  child: SizedBox(
                                    height: 54.w,
                                    width: 54.w,
                                    child: CachedNetworkImage(
                                      imageUrl: "${item.photourl}",
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 15.w,
                                    left: 0.w,
                                    right: 0.w,
                                  ),
                                  width: 250.w,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        width: 1,
                                        color: Color(0xffe5efe5),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        height: 42.w,
                                        child: Text(
                                          item.name ?? 'a',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.thirdElement,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: controller.contactList.length,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
