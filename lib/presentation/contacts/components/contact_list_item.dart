// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ContactListItem extends StatelessWidget {
  ContactListItem(
      {required this.email,
      required this.name,
      required this.imgUrl,
      required this.onTap,
      super.key});
  String name;
  String email;
  String imgUrl;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        radius: 27,
        child: CachedNetworkImage(imageUrl: imgUrl),
      ),
      title: Text(name),
      subtitle: Text(email),
      trailing: const Text('Go Chat'),
    );
  }
}
