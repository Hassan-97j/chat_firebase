import 'package:chat_firebase/common/entities/entities.dart';
import 'package:get/get.dart';

class ProfileState {
  var headerDetails = Rx<UserLoginResponseEntity?>(null);
  var meListItem = <MeListItem>[].obs;
}
