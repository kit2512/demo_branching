import 'package:demo_branching/src/blocs/capture_image_cubit/capture_image_cubit.dart';
import 'package:demo_branching/src/repositories/image_repository/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaptureImageScreen extends StatelessWidget {
  const CaptureImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CaptureImageCubit>(
      create: (context) =>
          CaptureImageCubit(imageRepository: context.read<ImageRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Capture Image'),
        ),
        body: CaptureImageView(),
      ),
    );
  }
}

class CaptureImageView extends StatelessWidget {
  const CaptureImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaptureImageCubit, CaptureImageState>(
      listener: (context, state) {
        if (state is CaptureImageSaving) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Saving image...')),
            );
        }
        if (state is CaptureImageSaved) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Saved image...')),
            );
        }
      },
      child: BlocBuilder<CaptureImageCubit, CaptureImageState>(
          builder: (context, state) {
        if (state is CaptureImageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CaptureImageError) {
          return const Center(
            child: Text("Error loading message"),
          );
        }
        if (state is CaptureImageLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(state.imageFile),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: context.read<CaptureImageCubit>().onCaptureImage,
                    child: const Text("Retake"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<CaptureImageCubit>()
                          .onSaveImage(state.imageFile);
                    },
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          );
        }
        return Center(
          child: ElevatedButton(
            child: const Text('Capture Image'),
            onPressed: context.read<CaptureImageCubit>().onCaptureImage,
          ),
        );
      }),
    );
  }
}
