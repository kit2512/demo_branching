import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:demo_branching/src/repositories/image_repository/image_repository.dart';

part 'gallery_image_state.dart';

class GalleryImageCubit extends Cubit<GalleryImageState> {
  final ImageRepository _imageRepository;

  GalleryImageCubit({required ImageRepository imageRepository})
      : _imageRepository = imageRepository,
        super(GalleryImageInitial());

  void onPickImage() async {
    try {
      emit(GalleryImageLoading());
      final imageFile = await _imageRepository.pickImage();
      if (imageFile != null) {
        emit(GalleryImageLoaded(imageFile: imageFile));
      } else {
        emit(GalleryImageInitial());
      }
    } on ImagePickerException catch (_) {
      emit(GalleryImageError());
    }
  }
}
