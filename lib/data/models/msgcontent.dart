import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  final String? uid;
  final String? content;
  final String? type;
  final Timestamp? addtime;

  Msgcontent({
    this.uid,
    this.content,
    this.type,
    this.addtime,
  });

 
}
