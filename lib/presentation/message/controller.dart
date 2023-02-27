import 'package:chat_firebase/app/services/service_handler/user.dart';
import '../../app/config/app_config.dart/app_alert_dialogs.dart';
import 'package:chat_firebase/data/repositories/firebase_repo/message_repo.dart';
import 'package:chat_firebase/data/repositories/http_repo/maps_repo.dart';
import 'package:chat_firebase/data/repositories/location_repo.dart';
import 'package:chat_firebase/domain/interface/msg_model.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/fcm_repo_impl.dart';
import 'package:chat_firebase/domain/repositories/firebase_repo/message_repo_impl.dart';
import 'package:chat_firebase/domain/repositories/location_repo_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:get/get.dart';
import '../../data/repositories/firebase_repo/fcm_repo.dart';
import '../../domain/repositories/http_repo/maps_repo_impl.dart';

class MessageController extends GetxController {
  MessageRepo messageRepo = MessageRepoImpl();
  FCMRepo fcmRepo = FCMRepoImpl();
  MapsRepo mapsRepo = MapsRepoImpl();
  LocationRepo locationRepo = LocationRepoImpl();
  var msgList = <QueryDocumentSnapshot<MsgModel>>[];
  final token = UserStore.to.token;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  void onReady() {
    super.onReady();
    getUserLocation();
    getFCMToken();
  }

  void onRefresh() {
    loadAllData().then((_) {
      refreshController.refreshCompleted(resetFooterState: true);
    }).catchError((_) {
      refreshController.refreshFailed();
    });
    update();
  }

  void onLoading() {
    loadAllData().then((_) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
    update();
  }

  loadAllData() async {
    try {
      var fromMessages = await messageRepo.getFromMessages();
      var toMessages = await messageRepo.getToMessages();
      msgList.clear();
      update();
      if (fromMessages.docs.isNotEmpty) {
        msgList.assignAll(fromMessages.docs);
        update();
      }
      if (toMessages.docs.isNotEmpty) {
        msgList.assignAll(toMessages.docs);
        update();
      }
    } catch (e) {
      Dialogs.showSnackbar("error in fetching messages", '$e');
    }
    update();
  }

  getUserLocation() async {
    try {
      String address = await locationRepo.getLocationAddress();
      var response = await mapsRepo.getLocation(address);
      // print('location ka response ye hai bhai dekh le ghalt hai bad request theek kr lena $response');
      update();
      if (response != null) {
        await messageRepo.updateLocationToDB(response);
        update();
      }
    } catch (e) {
      // ignore: avoid_print
      print('error fetching location: $e');
    }
    update();
  }

  getFCMToken() async {
    var token = await fcmRepo.getFCMToken();
    if (token != null) {
      await messageRepo.updateFCMTokenToDb(token);
    }

    update();
  }
}
