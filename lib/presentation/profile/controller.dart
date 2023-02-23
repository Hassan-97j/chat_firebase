import 'package:get/get.dart';
import '../../data/repositories/firebase_repo/auth_repository.dart';
import '../../data/repositories/firebase_repo/profile_repository.dart';
import '../../domain/interface/user_model.dart';
import '../../domain/repositories/firebase_repo/profile_repo_impl.dart';
import '../../routes/routes.dart';
import '../../app/services/service_handler/user.dart';
import '../../domain/repositories/firebase_repo/auth_repo_impl.dart';

class ProfileController extends GetxController {
  final AuthRepository authRepository = AuthRepositoryImpl();
  UserLoginResponseEntityModel? headerDetails;
  var meListItem = <MeListItemModel>[];
  final ProfileRepository profileRepository = ProfileRepoImpl();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
    loadMeListItems();
  }

  Future<void> onLogOut() async {
    UserStore.to.onLogout();
    await authRepository.signOut();
    Get.offAndToNamed(AppRoutes.signin);
    update();
  }

  loadProfileData() async {
    var userData = await profileRepository.showUserProfileData();
    headerDetails = userData;
    update();
  }

  loadMeListItems() {
    meListItem = profileRepository.getMeListItems();
    update();
  }
}
