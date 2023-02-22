import 'dart:io';
import 'package:chat_firebase/data/repositories/image_picker_repo.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerRepoImpl implements ImagePickerRepo {
  final ImagePicker imagePicker = ImagePicker();
  File? photo;
  @override
  Future imageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
    } else {
      // ignore: avoid_print
      print('no image selected');
    }
  }

  @override
  Future imageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
    } else {
      // ignore: avoid_print
      print('no picture clicked');
    }
  }
}
