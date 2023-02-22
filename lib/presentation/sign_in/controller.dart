import 'package:chat_firebase/app/utils/dialogs.dart';
import 'package:chat_firebase/data/repositories/auth_repository.dart';

import 'package:chat_firebase/domain/repositories/auth_repo_impl.dart';
import 'package:chat_firebase/routes/routes.dart';

// import 'package:google_sign_in/google_sign_in.dart';
// import 'index.dart';
import 'package:get/get.dart';

// GoogleSignIn googleSignIn = GoogleSignIn(
//   scopes: <String>[
//     'openid',
//   ],
// );

class SignInController extends GetxController {
  // final state = SignInState();
  // SignInController();
  final AuthRepository authRepository = AuthRepositoryImpl();

  @override
  void onReady() {
    super.onReady();
    authRepository.checkUser();
  }

//sign in function
  Future<void> handleSignIn() async {
    try {
      Dialogs.showProgressBar();
      await authRepository.signInWithGoogle();
      // ignore: avoid_print
      print('Login Success');
      Dialogs.hideProgressBar();
      Get.offAndToNamed(AppRoutes.application);
    } catch (e) {
      Dialogs.showSnackbar('error', "$e");
      // ignore: avoid_print
      print(e);
    }
  }
}
