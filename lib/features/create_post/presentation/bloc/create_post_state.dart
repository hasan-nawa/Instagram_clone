import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';

class CreatePostState extends Equatable {
  final CreatePostEntity postEntity;
  final List<String> hashtagSuggestions;
  final List<String> userMentionSuggestions;
  final bool isLoadingSuggestions;
  final bool isSearchingUsers;

  const CreatePostState({
    required this.postEntity,
    this.hashtagSuggestions = const [],
    this.userMentionSuggestions = const [],
    this.isLoadingSuggestions = false,
    this.isSearchingUsers = false,
  });

  factory CreatePostState.initial() {
    return CreatePostState(
      postEntity: const CreatePostEntity(),
    );
  }

  CreatePostState copyWith({
    CreatePostEntity? postEntity,
    List<String>? hashtagSuggestions,
    List<String>? userMentionSuggestions,
    bool? isLoadingSuggestions,
    bool? isSearchingUsers,
  }) {
    return CreatePostState(
      postEntity: postEntity ?? this.postEntity,
      hashtagSuggestions: hashtagSuggestions ?? this.hashtagSuggestions,
      userMentionSuggestions: userMentionSuggestions ?? this.userMentionSuggestions,
      isLoadingSuggestions: isLoadingSuggestions ?? this.isLoadingSuggestions,
      isSearchingUsers: isSearchingUsers ?? this.isSearchingUsers,
    );
  }

  @override
  List<Object> get props => [
    postEntity,
    hashtagSuggestions,
    userMentionSuggestions,
    isLoadingSuggestions,
    isSearchingUsers,
  ];
}