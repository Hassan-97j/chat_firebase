import 'dart:io';
import 'package:chat_firebase/data/repositories/image_picker_repo.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerRepoImpl implements ImagePickerRepo {
  final ImagePicker _imagePicker = ImagePicker();
  File? _photo;
  @override
  File? get photo => _photo;
  @override
  ImagePicker get imagePicker => _imagePicker;

  set photo(File? value) => _photo = value;
  @override
  Future<XFile?> imageFromCamera() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.camera);
      return pickedFile;
    } catch (e) {
      // ignore: avoid_print
      print('error withimageFromCamera(): $e');
      rethrow;
    }
  }

  @override
  Future<XFile?> imageFromGallery() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      return pickedFile;
    } catch (e) {
      // ignore: avoid_print
      print('error imageFromGallery(): $e');
      rethrow;
    }
  }
}
