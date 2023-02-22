import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../app/services/service_handler/user.dart';
import '../../data/repositories/auth_repository.dart';
import '../interface/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>['openid'],
  );
  final db = FirebaseFirestore.instance;
  @override
  Future<void> signInWithGoogle() async {
    try {
      //invoke method
      var user = await googleSignIn.signIn();
      if (user != null) {
        //sign in with credentials
        final googleAuthentication = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuthentication.idToken,
          accessToken: googleAuthentication.accessToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        //////////////////////////////////////////////////////////////////
        // define user profile using the model
        String displayName = user.displayName ?? user.email;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl ?? '';
        UserLoginResponseEntityModel userProfile =
            UserLoginResponseEntityModel();
        userProfile.email = email;
        userProfile.accessToken = id;
        userProfile.displayName = displayName;
        userProfile.photoUrl = photoUrl;
        //////////////////////////////////////////////////////////////////
        // save profile to local storage using shared_prefernces
        UserStore.to.saveProfile(userProfile);
        //////////////////////////////////////////////////////////////////
        // also save user to the firestore firebase
        var userbase = await db
            .collection("users")
            .withConverter(
              fromFirestore: UserDataModel.fromFirestore,
              toFirestore: (UserDataModel userdata, options) =>
                  userdata.toFirestore(),
            )
            .where("id", isEqualTo: id)
            .get();
        //////////////////////////////////////////////////////////////////
        if (userbase.docs.isEmpty) {
          final data = UserDataModel(
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
                  fromFirestore: UserDataModel.fromFirestore,
                  toFirestore: (UserDataModel userdata, options) =>
                      userdata.toFirestore())
              .add(data);

          // ignore: avoid_print
          print('Login Success');
          // Get.offAndToNamed(AppRoutes.application);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    await googleSignIn.signOut();
  }

  @override
  checkUser() {
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
