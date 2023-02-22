// ignore_for_file: overridden_fields

import 'package:chat_firebase/data/models/msgcontent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MsgcontentModel extends Msgcontent {
  @override
  final String? uid;
  @override
  final String? content;
  @override
  final String? type;
  @override
  final Timestamp? addtime;

  MsgcontentModel({
    this.uid,
    this.content,
    this.type,
    this.addtime,
  }) : super(
          addtime: addtime,
          content: content,
          type: type,
          uid: uid,
        );

  factory MsgcontentModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MsgcontentModel(
      uid: data?['uid'],
      content: data?['content'],
      type: data?['type'],
      addtime: data?['addtime'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (content != null) "content": content,
      if (type != null) "type": type,
      if (addtime != null) "addtime": addtime,
    };
  }
}
