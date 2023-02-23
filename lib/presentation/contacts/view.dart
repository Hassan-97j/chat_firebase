import 'package:chat_firebase/app/config/values/values.dart';
import 'package:chat_firebase/app/utils/widgets/widgets.dart';
import 'package:chat_firebase/presentation/contacts/components/contact_list.dart';
import 'package:chat_firebase/presentation/contacts/controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactsController>(
      init: ContactsController(),
      builder: (_) => Scaffold(
        appBar: transparentAppBar(
          title: Text(
            'Contacts',
            style: TextStyle(
              color: AppColors.primaryBackground,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: const ContactList(),
      ),
    );
  }
}
