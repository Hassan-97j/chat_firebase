import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerRepo {
/////
  ImagePicker get _imagePicker;
  File? get _photo;
////
  ImagePicker get imagePicker => _imagePicker;
  File? get photo => _photo;
  Future imageFromGallery();
  Future imageFromCamera();
}
