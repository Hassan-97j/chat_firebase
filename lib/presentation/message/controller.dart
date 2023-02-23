import 'package:chat_firebase/app/services/service_handler/user.dart';
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
  var msgList = <QueryDocumentSnapshot<MsgModel>>[].obs;
  final token = UserStore.to.token;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

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
  }

  void onLoading() {
    loadAllData().then((_) {
      refreshController.loadComplete();
    }).catchError((_) {
      refreshController.loadFailed();
    });
  }

  loadAllData() async {
    var fromMessages = await messageRepo.getFromMessages();
    var toMessages = await messageRepo.getToMessages();
    msgList.clear();
    if (fromMessages.docs.isNotEmpty) {
      msgList.assignAll(fromMessages.docs);
    }
    if (toMessages.docs.isNotEmpty) {
      msgList.assignAll(toMessages.docs);
    }
    update();
  }

  getUserLocation() async {
    try {
      String address = await locationRepo.getLocationAddress();

      var response = await mapsRepo.getLocation(address);

      String? myAddress = response.results!.first.formattedAddress;
      if (myAddress != null) {
        await messageRepo.updateLocationToDB(myAddress);
      }
    } catch (e) {
      // ignore: avoid_print
      print('error fetching location: $e');
    }
  }

  getFCMToken() async {
    await fcmRepo.getFCMToken();
  }
}
