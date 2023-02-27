import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_firebase/app/config/app_config.dart/app_paddings.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatItem extends StatelessWidget {
  ChatItem({
    required this.data,
    this.ontap,
    required this.type,
    required this.mainAxisAlignment,
    required this.color,
    Key? key,
  }) : super(key: key);

  String data;
  Function()? ontap;
  String type;
  MainAxisAlignment mainAxisAlignment;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPAdding.vert10hor15,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 230, minHeight: 40),
            child: Container(
              margin: AppPAdding.right10,
              padding: AppPAdding.vert10hor15,

              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              // ignore: unrelated_type_equality_checks
              child: type == "text"
                  ? Text(data)
                  : ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 90,
                      ),
                      child: GestureDetector(
                        onTap: ontap,
                        child: CachedNetworkImage(imageUrl: data),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
