import 'package:chat_firebase/common/entities/user.dart';
import 'package:chat_firebase/common/routes/routes.dart';
import 'package:chat_firebase/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'index.dart';
import 'package:get/get.dart';

GoogleSignIn googleSignIn = GoogleSignIn(
  scopes: <String>[
    'openid',
  ],
);

class SignInController extends GetxController {
  final state = SignInState();
  SignInController();

  final db = FirebaseFirestore.instance;

  //sign in function
  Future<void> handleSignIn() async {
    try {
      var user = await googleSignIn.signIn();
      if (user != null) {
        final googleAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);

        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? '';
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        UserStore.to.saveProfile(userProfile);
        var userbase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserData.fromFirestore,
              toFirestore: (UserData userdata, options) =>
                  userdata.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();
        if (userbase.docs.isEmpty) {
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: "",
            fcmtoken: "",
            addtime: Timestamp.now(),
          );
          await db
              .collection("users")
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userdata, options) =>
                      userdata.toFirestore())
              .add(data);

          //toastInfo(msg: 'Login Success');
          // ignore: avoid_print
          print('Login Success');
          Get.offAndToNamed(AppRoutes.application);
        }
      }
    } catch (e) {
      // await toastInfo(msg: 'Login error');
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('User is currently logged out');
      } else {
        // ignore: avoid_print
        print('User is logged in');
      }
    });
  }
}
