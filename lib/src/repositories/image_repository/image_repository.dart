import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerException implements Exception {
  final String message;

  ImagePickerException(this.message);

  @override
  String toString() => message;
}

class ImageRepository {
  final ImagePicker _imagePicker;

  ImageRepository({ImagePicker? imagePicker})
      : _imagePicker = imagePicker ?? ImagePicker();

  Future<File?> pickImage() async {
    try {
      final XFile? imageFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (imageFile == null) {
        return null;
      } else {
        return File(imageFile.path);
      }
    } on Exception catch (e) {
      throw ImagePickerException(e.toString());
    }
  }

  Future<List<File>?> pickMultiPleImages() async {
    try {
      final List<XFile>? imageFiles = await _imagePicker.pickMultiImage();
      if (imageFiles == null) {
        return null;
      } else {
        return imageFiles
            .map((XFile imageFile) => File(imageFile.path))
            .toList();
      }
    } on Exception catch (e) {
      throw ImagePickerException(e.toString());
    }
  }

  Future<File?> captureImage() async {
    try {
      final XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 600,
      );
      if (imageFile == null) {
        return null;
      } else {
        return File(imageFile.path);
      }
    } on Exception catch (e) {
      throw ImagePickerException(e.toString());
    }
  }
}
