import 'package:equatable/equatable.dart';

class PostDetailEntity extends Equatable {
  final String id;
  final String username;
  final String userProfileImageUrl;
  final List<String> imageUrl;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final List<CommentEntity> comments;
  final DateTime createdAt;
  final bool isLiked;
  final bool isBookmarked;
  final List<String> hashtags;

  const PostDetailEntity({
    required this.id,
    required this.username,
    required this.userProfileImageUrl,
    required this.imageUrl,
    required this.caption,
    required this.likesCount,
    required this.comments,
    required this.commentsCount,
    required this.createdAt,
    required this.isLiked,
    required this.isBookmarked,
    required this.hashtags,
  });

  // Add a copyWith method for easier state updates
  PostDetailEntity copyWith({
    String? id,
    String? username,
    String? userProfileImageUrl,
    List<String>? imageUrl,
    String? caption,
    int? likesCount,
    List<CommentEntity>? comments,
    int? commentsCount,
    DateTime? createdAt,
    bool? isLiked,
    bool? isBookmarked,
    List<String>? hashtags,
  }) {
    return PostDetailEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likesCount: likesCount ?? this.likesCount,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      hashtags: hashtags ?? this.hashtags, commentsCount: commentsCount ?? this.commentsCount,
    );
  }

  @override
  List<Object> get props => [
    id,
    username,
    userProfileImageUrl,
    imageUrl,
    caption,
    likesCount,
    comments,
    createdAt,
    isLiked,
    isBookmarked,
    hashtags,
  ];
}

class CommentEntity extends Equatable {
  final String id;
  final String username;
  final String userProfileImageUrl;
  final String text;
  final DateTime createdAt;
  final int likesCount;
  final bool isLiked;

  const CommentEntity({
    required this.id,
    required this.username,
    required this.userProfileImageUrl,
    required this.text,
    required this.createdAt,
    required this.likesCount,
    required this.isLiked,
  });

  @override
  List<Object> get props => [
    id,
    username,
    userProfileImageUrl,
    text,
    createdAt,
    likesCount,
    isLiked
  ];
}