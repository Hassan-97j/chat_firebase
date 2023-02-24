import 'dart:io';
import 'package:get/get.dart';
import '../../app/utils/dialogs.dart';
import '../../domain/repositories/firebase_repo/auth_repo_impl.dart';
import '../../routes/routes.dart';
import '../../data/repositories/firebase_repo/auth_repository.dart';

class SignInController extends GetxController {
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
      
      await InternetAddress.lookup('google.com');
      await authRepository.signInWithGoogle();
   
      Dialogs.hideProgressBar();
      Get.offAndToNamed(AppRoutes.application);
  
      Dialogs.showSnackbar('succes', "'Login Success");
    } catch (e) {
      // ignore: avoid_print
      print('error: $e');
      Dialogs.hideProgressBar();
      Dialogs.showSnackbar('error', "No Internet Connection");
    }
    update();
  }

  checkUSerAvalabilty() async {
    await authRepository.checkUser();
    update();
  }
}
