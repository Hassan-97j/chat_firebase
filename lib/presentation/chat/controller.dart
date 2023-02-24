import 'dart:io';
import 'package:chat_firebase/app/services/service_handler/user.dart';
import 'package:chat_firebase/data/repositories/firebase_repo/storage_repo.dart';
import 'package:chat_firebase/data/repositories/image_picker_repo.dart';
import 'package:chat_firebase/domain/interface/msg_con_model.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/chat_repo_impl.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/storage_repo_impl.dart';
import 'package:chat_firebase/domain/repositories/image_picker_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../app/utils/randomstring.dart';
import 'package:get/get.dart';

import '../../data/repositories/firebase_repo/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository chatRepository = ChatrepositoryImpl();
  final ImagePickerRepo imagePickerRepo = ImagePickerRepoImpl();
  final StorageRepo storageRepo = StorageRepoImpl();
  var msgContentList = <MsgcontentModel>[];
  var toId = "";
  var toName = "";
  var toAvatar = "";
  var toLocation = "unknown";
  // ignore: prefer_typing_uninitialized_variables
  var docId;
  final textController = TextEditingController();
  ScrollController msgScrollController = ScrollController();
  FocusNode contentNode = FocusNode();
  final userId = UserStore.to.token;
  // ignore: prefer_typing_uninitialized_variables
  var listener;
  File? photo;

  Future imageFromGallery() async {
    var pickedFile = await imagePickerRepo.imageFromGallery();
    if (pickedFile != null) {
      photo = File(pickedFile.path);
    } else {
      // ignore: avoid_print
      print('no image selected');
    }
    update();
  }

  imageFromCamera() async {
    var pickedFile = await imagePickerRepo.imageFromCamera();
    if (pickedFile != null) {
      photo = File(pickedFile.path);
    } else {
      // ignore: avoid_print
      print('no image selected');
    }

    update();
  }

  Future getImgUrl(String name) async {
    var str = await storageRepo.getImgUrl(name);
    update();
    return str;
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = getRandomString(15) + photo!.path;
    try {
      storageRepo.uploadFile(fileName, photo).listen((event) async {
        switch (event.state) {
          case TaskState.running:
            break;
          case TaskState.paused:
            break;
          case TaskState.success:
            String imgUrl = await getImgUrl(fileName);
            await sendImageMessage(imgUrl);
            update();
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
    await chatRepository
        .addMessage(url, "image", docId)
        .then((DocumentReference doc) {
      // ignore: avoid_print
      print('image added successfully with id ${doc.id}');
      // uploadFile();
      textController.clear();
      Get.focusScope?.unfocus();
      update();
    });
    await chatRepository.updateMessage(" [image] ", docId);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() {
    var data = Get.arguments;
    docId = data['doc_id'];
    toId = data['to_uid'] ?? '';
    toName = data['to_name'] ?? '';
    toAvatar = data['to_avatar'] ?? '';
    update();
  }

  sendMessage() async {
    String sendContent = textController.text;
    await chatRepository
        .addMessage(sendContent, "text", docId)
        .then((DocumentReference doc) {
      // ignore: avoid_print
      print('document data added successfully with id ${doc.id}');
      textController.clear();
      Get.focusScope?.unfocus();
      update();
    });
    await chatRepository.updateMessage(sendContent, docId);
    update();
  }

  @override
  void onReady() {
    super.onReady();
    orderMessagesByLAstAdd();

    getLocation();
  }

  getLocation() async {
    await chatRepository.getLocationFromDB(toId, toLocation);
    update();
  }

  orderMessagesByLAstAdd() async {
    var orderedMessages = chatRepository.orderMsgByLastTime(docId);
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
    update();
  }

  @override
  void dispose() {
    msgScrollController.dispose();
    listener.cancel();
    super.dispose();
  }
}
