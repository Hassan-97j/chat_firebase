import 'package:chat_firebase/app/config/app_config.dart/app_textstyle.dart';
import 'package:chat_firebase/presentation/contacts/controller.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/contact_list_item.dart';

class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsController>(
      init: ContactsController(),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: !controller.isLoading
            ? controller.contactList.isEmpty
                ? Center(
                    child: Text(
                      'No Contacts added yet!',
                      style: AppTextStyles.onpPrimary26TextStyle,
                    ),
                  )
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.zero,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var item = controller.contactList[index];
                              return ContactListItem(
                                email: item.email ?? '',
                                name: item.name ?? "",
                                imgUrl: item.photourl,
                                onTap: () async {
                                  if (item.id != null) {
                                    await controller.goChat(item);
                                  }
                                },
                              );
                            },
                            childCount: controller.contactList.length,
                          ),
                        ),
                      ),
                    ],
                  )

            //const ContactList()
            :  Center(child: CircularProgressIndicator(
              color: Get.theme.colorScheme.surface,
            )),
      ),
    );
  }
}
