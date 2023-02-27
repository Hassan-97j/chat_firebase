import 'dart:convert';
import 'package:get/get.dart';
import '../storage_service.dart';
import '../../../domain/interface/user_model.dart';
import '../../config/app_config.dart/app_strings.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;

  String token = '';

  final _profile = UserLoginResponseEntityModel().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntityModel get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(StorageStrings.store_UserTokenKey);
    var profileOffline =
        StorageService.to.getString(StorageStrings.store_UserProfileKey);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(
          UserLoginResponseEntityModel.fromJson(jsonDecode(profileOffline)));
    }
  }

  Future<void> setToken(String value) async {
    await StorageService.to.setString(StorageStrings.store_UserTokenKey, value);
    token = value;
  }

  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    return StorageService.to.getString(StorageStrings.store_UserProfileKey);
  }

  Future<void> saveProfile(UserLoginResponseEntityModel profile) async {
    _isLogin.value = true;
    StorageService.to
        .setString(StorageStrings.store_UserProfileKey, jsonEncode(profile));
    setToken(profile.accessToken!);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(StorageStrings.store_UserTokenKey);
    await StorageService.to.remove(StorageStrings.store_UserProfileKey);
    _isLogin.value = false;
    token = '';
  }
}
