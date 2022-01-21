part of 'capture_image_cubit.dart';

@immutable
abstract class CaptureImageState {}

class CaptureImageInitial extends CaptureImageState {}

class CaptureImageLoading extends CaptureImageState {}

class CaptureImageSaving extends CaptureImageState {}

class CaptureImageSaved extends CaptureImageState {
  final File file;
  CaptureImageSaved(this.file);
}

class CaptureImageLoaded extends CaptureImageState {
  final File imageFile;

  CaptureImageLoaded({
    required this.imageFile,
  });
}

class CaptureImageError extends CaptureImageState {}
