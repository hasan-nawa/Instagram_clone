import 'package:equatable/equatable.dart';

class SearchResultEntity extends Equatable {
  final List<UserEntity> users;
  final List<HashtagEntity> hashtags;
  final List<PostPreviewEntity> topPosts;

  const SearchResultEntity({
    required this.users,
    required this.hashtags,
    required this.topPosts,
  });

  @override
  List<Object> get props => [users, hashtags, topPosts];
}

class UserEntity extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String profileImageUrl;
  final bool isVerified;
  final bool isFollowing;

  const UserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.profileImageUrl,
    required this.isVerified,
    required this.isFollowing,
  });

  @override
  List<Object> get props => [
    id,
    username,
    fullName,
    profileImageUrl,
    isVerified,
    isFollowing,
  ];
}

class HashtagEntity extends Equatable {
  final String name;
  final int postsCount;

  const HashtagEntity({
    required this.name,
    required this.postsCount,
  });

  @override
  List<Object> get props => [name, postsCount];
}

class PostPreviewEntity extends Equatable {
  final String id;
  final String imageUrl;
  final int likesCount;
  final int commentsCount;

  const PostPreviewEntity({
    required this.id,
    required this.imageUrl,
    required this.likesCount,
    required this.commentsCount,
  });

  @override
  List<Object> get props => [id, imageUrl, likesCount, commentsCount];
}