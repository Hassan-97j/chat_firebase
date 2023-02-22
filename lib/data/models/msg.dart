// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Msg {
  final String? from_uid;
  final String? to_uid;
  final String? from_name;
  final String? to_name;
  final String? from_avatar;
  final String? to_avatar;
  final String? last_msg;
  final Timestamp? last_time;
  final int? msg_num;

  Msg({
    this.from_uid,
    this.to_uid,
    this.from_name,
    this.to_name,
    this.from_avatar,
    this.to_avatar,
    this.last_msg,
    this.last_time,
    this.msg_num,
  });
}
