import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String id;
  final String username;
  final String userProfileImageUrl;
  final List<String> imageUrl;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isLiked;
  final bool isBookmarked;
  final List<String> hashtags;

  const PostEntity({
    required this.id,
    required this.username,
    required this.userProfileImageUrl,
    required this.imageUrl,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.isLiked,
    required this.isBookmarked,
    required this.hashtags,
  });

  @override
  List<Object> get props => [
    id,
    username,
    userProfileImageUrl,
    imageUrl,
    caption,
    likesCount,
    commentsCount,
    createdAt,
    isLiked,
    isBookmarked,
    hashtags,
  ];
}
