import 'dart:io';
import 'package:chat_firebase/app/services/service_handler/user.dart';
import 'package:chat_firebase/domain/interface/msg_con_model.dart';
import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/utils/security.dart';
import 'index.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final state = ChatState();
  ChatController();
  // ignore: prefer_typing_uninitialized_variables
  var docId;
  final textController = TextEditingController();
  ScrollController msgScrollController = ScrollController();
  FocusNode contentNode = FocusNode();
  final userId = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  // ignore: prefer_typing_uninitialized_variables
  var listener;
  File? photo;
  final ImagePicker imagePicker = ImagePicker();

  Future imageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
    } else {
      // ignore: avoid_print
      print('no image selected');
    }
  }

  Future getImgUrl(String name) async {
    final spaceRef = FirebaseStorage.instance.ref("Chat").child(name);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = getRandomString(15) + photo!.path;
    try {
      final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      ref.putFile(photo!).snapshotEvents.listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(fileName);
            sendImageMessage(imgUrl);
            break;
          case TaskState.canceled:
            break;
          case TaskState.error:
            break;
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('there is an error $e');
    }
  }

  sendImageMessage(String url) async {
    final content = MsgcontentModel(
      uid: userId,
      content: url,
      type: "image",
      addtime: Timestamp.now(),
    );
    await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: MsgcontentModel.fromFirestore,
          toFirestore: (MsgcontentModel msgcontent, options) {
            return msgcontent.toFirestore();
          },
        )
        .add(content)
        .then((DocumentReference doc) {
      // ignore: avoid_print
      print('document data added successfully with id ${doc.id}');
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(docId).update(
      {
        "last_msg": "[image]",
        "last_time": Timestamp.now(),
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    docId = data['doc_id'];
    state.toId.value = data['to_uid'] ?? '';
    state.toName.value = data['to_name'] ?? '';
    state.toAvatar.value = data['to_avatar'] ?? '';
  }

  sendMessage() async {
    String sendContent = textController.text;
    final content = MsgcontentModel(
      uid: userId,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now(),
    );
    await db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: MsgcontentModel.fromFirestore,
          toFirestore: (MsgcontentModel msgcontent, options) {
            return msgcontent.toFirestore();
          },
        )
        .add(content)
        .then((DocumentReference doc) {
      // ignore: avoid_print
      print('document data added successfully with id ${doc.id}');
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await db.collection("message").doc(docId).update(
      {
        "last_msg": sendContent,
        "last_time": Timestamp.now(),
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    var messages = db
        .collection("message")
        .doc(docId)
        .collection("msglist")
        .withConverter(
          fromFirestore: MsgcontentModel.fromFirestore,
          toFirestore: (MsgcontentModel msgcontent, options) {
            return msgcontent.toFirestore();
          },
        )
        .orderBy("addtime", descending: false);
    state.msgContentList.clear();
    listener = messages.snapshots().listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              state.msgContentList.insert(0, change.doc.data()!);
            }
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }
      }
      // ignore: avoid_print
    }, onError: (error) => print('Listen Failed: $error'));
    getLocation();
  }

  getLocation() async {
    try {
      var userLocation = await db
          .collection("users")
          .where("id", isEqualTo: state.toId.value)
          .withConverter(
            fromFirestore: UserDataModel.fromFirestore,
            toFirestore: (UserDataModel userData, options) {
              return userData.toFirestore();
            },
          )
          .get();
      var location = userLocation.docs.first.data().location;
      if (location != '') {
        state.toLocation.value = location ?? "Unknown";
      }
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
    }
  }

  @override
  void dispose() {
    msgScrollController.dispose();
    listener.cancel();
    super.dispose();
  }
}
