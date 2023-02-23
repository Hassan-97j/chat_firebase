import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class InstancesDeclare {
  GoogleSignIn get _googleSignIn;
  FirebaseFirestore get _db;
  FirebaseAuth get _fbAuth;
  //
  get googleSignIn => _googleSignIn;
  get db => _db;
  get fbAuth => _fbAuth;
}
