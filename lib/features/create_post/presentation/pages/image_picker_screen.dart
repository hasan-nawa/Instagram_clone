import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_bloc.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_event.dart';
import 'package:instagram_clone/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:instagram_clone/di.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _galleryImages = [];

  @override
  void initState() {
    super.initState();
    if(context.read<NavigationBloc>().state.currentIndex == 2){
      _loadGalleryImages();
    }
  }

  Future<void> _loadGalleryImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _galleryImages = images;
        });
      }
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_camera),
            onPressed: () async {
              final XFile? image = await _picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                if (!mounted) return;
                // Navigate to CreatePostScreen with the selected image
                _navigateToCreatePostScreen(context, image.path);
              }
            },
          ),
        ],
      ),
      body: _galleryImages.isEmpty
          ? const Center(
        child: Text('No images found. Tap the camera icon to take a picture.'),
      )
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: _galleryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to CreatePostScreen with the selected image
              _navigateToCreatePostScreen(context, _galleryImages[index].path);
            },
            child: Image.file(
              File(_galleryImages[index].path),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _loadGalleryImages(),
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _navigateToCreatePostScreen(BuildContext context, String imagePath) {
    // Create a new instance of the bloc specifically for this navigation flow
    final createPostBloc = sl<CreatePostBloc>();
    // Set the selected image in the bloc
    createPostBloc.add(ImageSelectedEvent(imagePath));

    // Navigate to the CreatePostScreen with the new bloc instance
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => createPostBloc,
          child: const CreatePostScreen(),
        ),
      ),
    );
  }
}