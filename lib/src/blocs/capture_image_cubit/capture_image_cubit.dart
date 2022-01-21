import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_branching/src/repositories/image_repository/image_repository.dart';
import 'package:meta/meta.dart';

part 'capture_image_state.dart';

class CaptureImageCubit extends Cubit<CaptureImageState> {
  final ImageRepository _imageRepository;

  CaptureImageCubit({required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(CaptureImageInitial());

  void onCaptureImage() async {
    try {
      emit(CaptureImageLoading());
      final imageFile = await _imageRepository.captureImage();
      if (imageFile != null) {
        emit(CaptureImageLoaded(imageFile: imageFile));
      } else {
        emit(CaptureImageInitial());
      }
    } on ImagePickerException catch (_) {
      emit(CaptureImageError());
    }
  }

  void onSaveImage(File file) async {
    emit(CaptureImageSaving());
    final newFile = await _imageRepository.saveImage(file);
    emit(CaptureImageSaved(newFile));
  }
}
