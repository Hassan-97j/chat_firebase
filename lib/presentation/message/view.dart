import 'package:chat_firebase/presentation/message/components/message_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/config/values/colors.dart';
import '../../app/utils/widgets/app.dart';
import 'index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(
        title: Text(
          'Messages',
          style: TextStyle(
            color: AppColors.primaryBackground,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: const MessageList(),
    );
  }
}
