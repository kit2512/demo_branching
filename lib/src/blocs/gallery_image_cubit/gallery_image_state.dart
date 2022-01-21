part of 'gallery_image_cubit.dart';

abstract class GalleryImageState {}

class GalleryImageInitial extends GalleryImageState {}

class GalleryImageLoading extends GalleryImageState {}

class GalleryImageLoaded extends GalleryImageState {
  final File imageFile;

  GalleryImageLoaded({
    required this.imageFile,
  });
}

class GalleryImageError extends GalleryImageState {}
