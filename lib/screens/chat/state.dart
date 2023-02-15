import 'package:chat_firebase/common/entities/entities.dart';
import 'package:get/get.dart';

class ChatState {
  var msgContentList = <Msgcontent>[].obs;
  var toId = "".obs;
  var toName = "".obs;
  var toAvatar = "".obs;
  var toLocation = "unknown".obs;
}
