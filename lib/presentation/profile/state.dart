import 'package:chat_firebase/domain/interface/user_model.dart';
import 'package:get/get.dart';

class ProfileState {
  var headerDetails = Rx<UserLoginResponseEntityModel?>(null);
  var meListItem = <MeListItemModel>[].obs;
}
