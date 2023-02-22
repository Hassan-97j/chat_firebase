import 'package:chat_firebase/domain/interface/msg_con_model.dart';
import 'package:get/get.dart';

class ChatState {
  var msgContentList = <MsgcontentModel>[].obs;
  var toId = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var toLocation = "unknown".obs;
}
