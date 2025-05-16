import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_bloc.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_event.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_state.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_event.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  void _selectImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  _getImage(ImageSource.gallery, context);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera, context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source, BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      if (!mounted) return;
      context.read<CreatePostBloc>().add(ImageSelectedEvent(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    // The BlocProvider should now be coming from the parent
    return BlocConsumer<CreatePostBloc, CreatePostState>(
      listener: (context, state) {
        if (state.postEntity.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Post created successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          // Reset the create post state
          context.read<CreatePostBloc>().add(ClearCreatePostEvent());

          // Go back to previous screen
          Navigator.of(context).pop();

          // Go back to home/feed screen if we can find the NavigationBloc
          // This is safer than directly trying to access the NavigationBloc
          try {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();

              // Try to find the NavigationBloc higher up in the widget tree
              final navigationBloc = BlocProvider.of<NavigationBloc>(context, listen: false);
              navigationBloc.add(ChangeTabEvent(0));
            }
          } catch (e) {
            // If we can't find the NavigationBloc, just go back
            Navigator.of(context).pop();
          }
        }

        if (state.postEntity.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.postEntity.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Post'),
            actions: [
              if (state.postEntity.imagePath != null)
                TextButton(
                  onPressed: state.postEntity.isUploading
                      ? null
                      : () {
                    context.read<CreatePostBloc>().add(UploadPostEvent());
                  },
                  child: const Text(
                    'Share',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.postEntity.isUploading)
                  LinearProgressIndicator(
                    value: state.postEntity.uploadProgress,
                  ),

                // Image selection
                GestureDetector(
                  onTap: () => _selectImage(context),
                  child: Container(
                    height: 300,
                    color: Colors.grey[300],
                    child: state.postEntity.imagePath != null
                        ? Image.file(
                      File(state.postEntity.imagePath!),
                      fit: BoxFit.cover,
                    )
                        : const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                // Continue with the rest of the UI...
                // [rest of your existing UI code stays the same]

                // Caption input
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a caption...',
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    onChanged: (value) {
                      context.read<CreatePostBloc>().add(CaptionChangedEvent(value));

                      // Check for hashtag to suggest
                      if (value.contains('#')) {
                        final List<String> words = value.split(' ');
                        for (final word in words) {
                          if (word.startsWith('#') && word.length > 1) {
                            context.read<CreatePostBloc>().add(
                              GetHashtagSuggestionsEvent(word.substring(1)),
                            );
                            break;
                          }
                        }
                      }

                      // Check for mention to suggest
                      if (value.contains('@')) {
                        final List<String> words = value.split(' ');
                        for (final word in words) {
                          if (word.startsWith('@') && word.length > 1) {
                            context.read<CreatePostBloc>().add(
                              SearchUsersForMentionEvent(word.substring(1)),
                            );
                            break;
                          }
                        }
                      }
                    },
                  ),
                ),

                // Keep all other existing UI code...

                // Hashtag suggestions
                if (state.hashtagSuggestions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Suggested Hashtags',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.hashtagSuggestions.map((hashtag) {
                            return GestureDetector(
                              onTap: () {
                                context.read<CreatePostBloc>().add(AddHashtagEvent(hashtag));
                                _captionController.text += ' #$hashtag';
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text('#$hashtag'),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                // User mention suggestions
                if (state.userMentionSuggestions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mention Users',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.userMentionSuggestions.length,
                            itemBuilder: (context, index) {
                              final username = state.userMentionSuggestions[index];
                              return GestureDetector(
                                onTap: () {
                                  context.read<CreatePostBloc>().add(AddMentionEvent(username));
                                  _captionController.text += ' @$username';
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text('@$username'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                // Selected hashtags and mentioned users sections remain unchanged

                // Selected hashtags
                if (state.postEntity.hashtags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Selected Hashtags',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.postEntity.hashtags.map((hashtag) {
                            return GestureDetector(
                              onTap: () {
                                context.read<CreatePostBloc>().add(RemoveHashtagEvent(hashtag));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '#$hashtag',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                // Mentioned users
                if (state.postEntity.mentionedUsers.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mentioned Users',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: state.postEntity.mentionedUsers.map((username) {
                            return GestureDetector(
                              onTap: () {
                                context.read<CreatePostBloc>().add(RemoveMentionEvent(username));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '@$username',
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}