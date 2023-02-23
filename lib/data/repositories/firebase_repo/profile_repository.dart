import '../../../domain/interface/user_model.dart';

abstract class ProfileRepository {
  Future<UserLoginResponseEntityModel> showUserProfileData();
  List<MeListItemModel> getMeListItems();
}
