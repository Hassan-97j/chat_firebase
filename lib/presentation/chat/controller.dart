import 'dart:io';
import 'package:chat_firebase/app/services/service_handler/user.dart';
import 'package:chat_firebase/data/repositories/image_picker_repo.dart';
import 'package:chat_firebase/domain/interface/msg_con_model.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/chat_repo_impl.dart';
import 'package:chat_firebase/domain/repositories/image_picker_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/utils/security.dart';
import 'package:get/get.dart';

import '../../data/repositories/firebase_repo/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository chatRepository = ChatrepositoryImpl();
  final ImagePickerRepo imagePickerRepo = ImagePickerRepoImpl();
  // final state = ChatState();
  // ChatController();
  var msgContentList = <MsgcontentModel>[].obs;
  var toId = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var toLocation = "unknown".obs;
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
    photo = await imagePickerRepo.imageFromGallery();
    // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   photo = File(pickedFile.path);
    // } else {
    //   // ignore: avoid_print
    //   print('no image selected');
    // }
  }

  Future imageFromCamera() async {
    photo = await imagePickerRepo.imageFromCamera();
    // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   photo = File(pickedFile.path);
    // } else {
    //   // ignore: avoid_print
    //   print('no image selected');
    // }
  }

  Future getImgUrl(String name) async {
    var str = await chatRepository.getImgUrl(name);
    // final spaceRef = FirebaseStorage.instance.ref("Chat").child(name);
    // var str = await spaceRef.getDownloadURL();
    return str;
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = getRandomString(15) + photo!.path;
    try {
      // final ref = FirebaseStorage.instance.ref("chat").child(fileName);
      // ref.putFile(photo!).snapshotEvents
      chatRepository.uploadFile(fileName).listen((event) async {
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
    await chatRepository.addMessage(url, "image").then((DocumentReference doc) {
      // ignore: avoid_print
      print('document data added successfully with id ${doc.id}');
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await chatRepository.updateMessage("[image]");
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    docId = data['doc_id'];
    toId.value = data['to_uid'] ?? '';
    toName.value = data['to_name'] ?? '';
    toAvatar.value = data['to_avatar'] ?? '';
  }

  sendMessage() async {
    String sendContent = textController.text;
    await chatRepository
        .addMessage(sendContent, "text")
        .then((DocumentReference doc) {
      // ignore: avoid_print
      print('document data added successfully with id ${doc.id}');
      textController.clear();
      Get.focusScope?.unfocus();
    });
    await chatRepository.updateMessage(sendContent);
  }

  @override
  void onReady() {
    super.onReady();
    orderMessagesByLAstAdd();
    // var messages = db
    //     .collection("message")
    //     .doc(docId)
    //     .collection("msglist")
    //     .withConverter(
    //       fromFirestore: MsgcontentModel.fromFirestore,
    //       toFirestore: (MsgcontentModel msgcontent, options) {
    //         return msgcontent.toFirestore();
    //       },
    //     )
    //     .orderBy("addtime", descending: false);
    // msgContentList.clear();
    // listener = messages.snapshots()
    // .listen((event) {
    //   for (var change in event.docChanges) {
    //     switch (change.type) {
    //       case DocumentChangeType.added:
    //         if (change.doc.data() != null) {
    //           msgContentList.insert(0, change.doc.data()!);
    //         }
    //         break;
    //       case DocumentChangeType.modified:
    //         break;
    //       case DocumentChangeType.removed:
    //         break;
    //     }
    //   }
    //   // ignore: avoid_print
    // }, onError: (error) => print('Listen Failed: $error'));
    getLocation();
  }

  getLocation() async {
    await chatRepository.getLocationFromDB(toId.value, toLocation.value);
    // try {
    //   var userLocation = await db
    //       .collection("users")
    //       .where("id", isEqualTo: toId.value)
    //       .withConverter(
    //         fromFirestore: UserDataModel.fromFirestore,
    //         toFirestore: (UserDataModel userData, options) {
    //           return userData.toFirestore();
    //         },
    //       )
    //       .get();
    //   var location = userLocation.docs.first.data().location;
    //   if (location != '') {
    //     toLocation.value = location ?? "Unknown";
    //   }
    // } catch (e) {
    //   // ignore: avoid_print
    //   print('error: $e');
    // }
  }

  orderMessagesByLAstAdd() async {
    var orderedMessages = chatRepository.orderMsgByLastTime();
    listener = orderedMessages.snapshots();
    msgContentList.clear();
    listener.listen((event) {
      for (var change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            if (change.doc.data() != null) {
              msgContentList.insert(0, change.doc.data());
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
  }

  @override
  void dispose() {
    msgScrollController.dispose();
    listener.cancel();
    super.dispose();
  }
}
