import 'package:demo_branching/src/blocs/gallery_image_cubit/gallery_image_cubit.dart';
import 'package:demo_branching/src/repositories/image_repository/image_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GalleryImageScreen extends StatelessWidget {
  const GalleryImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GalleryImageCubit>(
      create: (context) =>
          GalleryImageCubit(imageRepository: context.read<ImageRepository>()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery Image'),
        ),
        body: GalleryImageView(),
      ),
    );
  }
}

class GalleryImageView extends StatelessWidget {
  const GalleryImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<GalleryImageCubit, GalleryImageState>(
          builder: (context, state) {
        if (state is GalleryImageLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GalleryImageError) {
          return const Center(
            child: Text("Error loading message"),
          );
        }
        if (state is GalleryImageLoaded) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(state.imageFile),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: context.read<GalleryImageCubit>().onPickImage,
                    child: const Text("Retake"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          );
        }
        return Center(
          child: ElevatedButton(
            child: const Text('Gallery Image'),
            onPressed: context.read<GalleryImageCubit>().onPickImage,
          ),
        );
      }),
    );
  }
}
