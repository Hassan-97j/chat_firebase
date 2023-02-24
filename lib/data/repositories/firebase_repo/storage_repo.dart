import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageRepo {
  FirebaseStorage get _storage;
  File? get _photo;
  //
  File? get photo => _photo;
  FirebaseStorage get storage => _storage;
  Future<String> getImgUrl(String name);
  Stream<TaskSnapshot> uploadFile(String fileName, File? file);
}
