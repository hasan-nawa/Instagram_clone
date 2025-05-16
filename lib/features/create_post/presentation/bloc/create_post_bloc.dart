import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/create_post.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/get_suggested_hashtags.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/search_users.dart';
import 'package:instagram_clone/features/create_post/domain/usecases/upload_image.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_event.dart';
import 'package:instagram_clone/features/create_post/presentation/bloc/create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final UploadImage uploadImage;
  final CreatePost createPost;
  final GetSuggestedHashtags getSuggestedHashtags;
  final SearchUsers searchUsers;

  CreatePostBloc({
    required this.uploadImage,
    required this.createPost,
    required this.getSuggestedHashtags,
    required this.searchUsers,
  }) : super(CreatePostState.initial()) {
    on<ImageSelectedEvent>(_onImageSelected);
    on<CaptionChangedEvent>(_onCaptionChanged);
    on<UploadPostEvent>(_onUploadPost);
    on<ClearCreatePostEvent>(_onClearCreatePost);
    on<GetHashtagSuggestionsEvent>(_onGetHashtagSuggestions);
    on<AddHashtagEvent>(_onAddHashtag);
    on<RemoveHashtagEvent>(_onRemoveHashtag);
    on<SearchUsersForMentionEvent>(_onSearchUsersForMention);
    on<AddMentionEvent>(_onAddMention);
    on<RemoveMentionEvent>(_onRemoveMention);
  }

  void _onImageSelected(ImageSelectedEvent event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(
      postEntity: state.postEntity.copyWith(
        imagePath: event.imagePath,
      ),
    ));
  }

  void _onCaptionChanged(CaptionChangedEvent event, Emitter<CreatePostState> emit) {
    emit(state.copyWith(
      postEntity: state.postEntity.copyWith(
        caption: event.caption,
      ),
    ));
  }

  void _onUploadPost(UploadPostEvent event, Emitter<CreatePostState> emit) async {
    if (state.postEntity.imagePath == null) {
      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          errorMessage: 'Please select an image',
        ),
      ));
      return;
    }

    emit(state.copyWith(
      postEntity: state.postEntity.copyWith(
        isUploading: true,
        uploadProgress: 0.0,
        errorMessage: null,
      ),
    ));

    try {
      // Upload the image
      final imageUrl = await uploadImage(
        UploadImageParams(
          image: File(state.postEntity.imagePath!),
          onProgress: (progress) {
            add(UpdateUploadProgressEvent(progress));
          },
        ),
      );

      // Create the post with the uploaded image URL
      await createPost(
        state.postEntity.copyWith(
          imagePath: imageUrl,
        ),
      );

      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          isUploading: false,
          uploadProgress: 1.0,
          isSuccess: true,
        ),
      ));
    } catch (e) {
      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          isUploading: false,
          errorMessage: e.toString(),
        ),
      ));
    }
  }

  void _onClearCreatePost(ClearCreatePostEvent event, Emitter<CreatePostState> emit) {
    emit(CreatePostState.initial());
  }

  void _onGetHashtagSuggestions(GetHashtagSuggestionsEvent event, Emitter<CreatePostState> emit) async {
    emit(state.copyWith(isLoadingSuggestions: true));

    try {
      final suggestions = await getSuggestedHashtags(event.text);
      emit(state.copyWith(
        hashtagSuggestions: suggestions,
        isLoadingSuggestions: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        hashtagSuggestions: [],
        isLoadingSuggestions: false,
      ));
    }
  }

  void _onAddHashtag(AddHashtagEvent event, Emitter<CreatePostState> emit) {
    final currentHashtags = List<String>.from(state.postEntity.hashtags);

    // Only add if not already in the list
    if (!currentHashtags.contains(event.hashtag)) {
      currentHashtags.add(event.hashtag);

      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          hashtags: currentHashtags,
        ),
      ));
    }
  }

  void _onRemoveHashtag(RemoveHashtagEvent event, Emitter<CreatePostState> emit) {
    final currentHashtags = List<String>.from(state.postEntity.hashtags);
    currentHashtags.remove(event.hashtag);

    emit(state.copyWith(
      postEntity: state.postEntity.copyWith(
        hashtags: currentHashtags,
      ),
    ));
  }

  void _onSearchUsersForMention(SearchUsersForMentionEvent event, Emitter<CreatePostState> emit) async {
    emit(state.copyWith(isSearchingUsers: true));

    try {
      final users = await searchUsers(event.query);
      emit(state.copyWith(
        userMentionSuggestions: users,
        isSearchingUsers: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        userMentionSuggestions: [],
        isSearchingUsers: false,
      ));
    }
  }

  void _onAddMention(AddMentionEvent event, Emitter<CreatePostState> emit) {
    final currentMentions = List<String>.from(state.postEntity.mentionedUsers);

    // Only add if not already in the list
    if (!currentMentions.contains(event.username)) {
      currentMentions.add(event.username);

      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          mentionedUsers: currentMentions,
        ),
      ));
    }
  }

  void _onRemoveMention(RemoveMentionEvent event, Emitter<CreatePostState> emit) {
    final currentMentions = List<String>.from(state.postEntity.mentionedUsers);
    currentMentions.remove(event.username);

    emit(state.copyWith(
      postEntity: state.postEntity.copyWith(
        mentionedUsers: currentMentions,
      ),
    ));
  }

  @override
  void onEvent(CreatePostEvent event) {
    if (event is UpdateUploadProgressEvent) {
      // Update progress without going through the regular event handling
      emit(state.copyWith(
        postEntity: state.postEntity.copyWith(
          uploadProgress: event.progress,
        ),
      ));
    } else {
      super.onEvent(event);
    }
  }
}