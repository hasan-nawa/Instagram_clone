import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required String id,
    required String username,
    required String userProfileImageUrl,
    required List<String> imageUrl,
    required String caption,
    required int likesCount,
    required int commentsCount,
    required DateTime createdAt,
    required bool isLiked,
    required bool isBookmarked,
    required List<String> hashtags,
  }) : super(
         id: id,
         username: username,
         userProfileImageUrl: userProfileImageUrl,
         imageUrl: imageUrl,
         caption: caption,
         likesCount: likesCount,
         commentsCount: commentsCount,
         createdAt: createdAt,
         isLiked: isLiked,
         isBookmarked: isBookmarked,
         hashtags: hashtags,
       );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      username: json['username'],
      userProfileImageUrl: json['userProfileImageUrl'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      createdAt: DateTime.parse(json['createdAt']),
      isLiked: json['isLiked'],
      isBookmarked: json['isBookmarked'],
      hashtags: List<String>.from(json['hashtags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userProfileImageUrl': userProfileImageUrl,
      'imageUrl': imageUrl,
      'caption': caption,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'hashtags': hashtags,
    };
  }
}
