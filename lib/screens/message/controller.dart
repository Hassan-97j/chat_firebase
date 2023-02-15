import 'package:chat_firebase/common/entities/entities.dart';
import 'package:chat_firebase/common/store/user.dart';
import 'package:chat_firebase/common/utils/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'index.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  final state = MessageState();
  MessageController();
  final token = UserStore.to.token;
  final db = FirebaseFirestore.instance;
  // ignore: prefer_typing_uninitialized_variables
  var listener;

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
    var fromMessages = await db
        .collection('message')
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) {
              return msg.toFirestore();
            })
        .where("from_uid", isEqualTo: token)
        .get();
    var toMessages = await db
        .collection('message')
        .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) {
              return msg.toFirestore();
            })
        .where("to_uid", isEqualTo: token)
        .get();
    state.msgList.clear();
    if (fromMessages.docs.isNotEmpty) {
      state.msgList.assignAll(fromMessages.docs);
    }
    if (toMessages.docs.isNotEmpty) {
      state.msgList.assignAll(toMessages.docs);
    }
  }

  getUserLocation() async {
    try {
      final location = await Location().getLocation();
      String address = "${location.latitude}, ${location.longitude}";
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=AIzaSyCMOW63IEO4ekawnyxGd8G2MRHztfkljF0";
      var response = await HttpUtil().get(url);
      MyLocation locationResponse = MyLocation.fromJson(response);
      if (locationResponse.status == "OK") {
        String? myAddress = locationResponse.results?.first.formattedAddress;
        if (myAddress != null) {
          var userLocation =
              await db.collection("users").where("id", isEqualTo: token).get();
          if (userLocation.docs.isNotEmpty) {
            var docId = userLocation.docs.first.id;
            await db.collection("users").doc(docId).update(
              {
                "location": myAddress,
              },
            );
          }
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('error fetching location: $e');
    }
  }

  getFCMToken() async {
    final fcmToken = FirebaseMessaging.instance.getToken();
    // ignore: unnecessary_null_comparison
    if (fcmToken != null) {
      var user =
          await db.collection("users").where("id", isEqualTo: token).get();
      if (user.docs.isNotEmpty) {
        var docId = user.docs.first.id;
        await db.collection("users").doc(docId).update(
          {
            "fcmtoken": fcmToken,
          },
        );
      }
    }
  }
}
