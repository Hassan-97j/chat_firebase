import 'dart:io';

import 'package:chat_firebase/data/repositories/firebase_repo/storage_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepoImpl implements StorageRepo {
  File? _photo;

  set photo(File? value) => _photo = value;

  @override
  File? get photo => _photo;
  @override
  get storage => FirebaseStorage.instance;
  @override
  Future<String> getImgUrl(String name) async {
    try {
      final spaceRef = storage.ref("chat").child(name);
      var str = await spaceRef.getDownloadURL();
      return str;
    } catch (e) {
      // ignore: avoid_print
      print('there is an error with getting image url: $e');
      rethrow;
    }
  }

  @override
  Stream<TaskSnapshot> uploadFile(String fileName, File? file) {
    try {
      final ref = storage.ref("chat").child(fileName);
      var eventSnapShot = ref.putFile(file!).snapshotEvents;
      return eventSnapShot;
    } catch (e) {
      // ignore: avoid_print
      print('there is an error with file upload: $e');
      rethrow;
    }
  }
}
