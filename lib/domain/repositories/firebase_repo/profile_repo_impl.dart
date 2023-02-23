import 'dart:convert';

import 'package:chat_firebase/presentation/profile/data/profile_page_data.dart';

import '../../../data/repositories/firebase_repo/profile_repository.dart';
import '../../interface/user_model.dart';

import '../../../app/services/service_handler/user.dart';

class ProfileRepoImpl implements ProfileRepository {
  @override
  Future<UserLoginResponseEntityModel> showUserProfileData() async {
    String profile = await UserStore.to.getProfile();
    if (profile.isNotEmpty) {
      UserLoginResponseEntityModel userData =
          UserLoginResponseEntityModel.fromJson(jsonDecode(profile));
      return userData;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  List<MeListItemModel> getMeListItems() {
    List<MeListItemModel> meListItems = [];

    for (Map<String, String> itemData in ProfilePageData.myListData) {
      MeListItemModel item = MeListItemModel(
        name: itemData["name"] ?? "",
        icon: itemData["icon"] ?? "",
        route: itemData["route"] ?? "",
      );
      meListItems.add(item);
    }
    return meListItems;
  }
}
