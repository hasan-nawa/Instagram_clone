import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';

class PostDetailModel extends PostDetailEntity {
  const PostDetailModel({
    required String id,
    required String username,
    required String userProfileImageUrl,
    required List<String> imageUrl,
    required String caption,
    required int likesCount,
    required List<CommentEntity> comments,
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
    comments: comments,
    commentsCount: commentsCount,
    createdAt: createdAt,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    hashtags: hashtags,
  );

  factory PostDetailModel.fromJson(Map<String, dynamic> json) {
    return PostDetailModel(
      id: json['id'],
      username: json['username'],
      userProfileImageUrl: json['userProfileImageUrl'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      comments: (json['comments'] as List)
          .map((comment) => CommentModel.fromJson(comment))
          .toList(),
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
      'comments': comments.map((comment) {
        if (comment is CommentModel) {
          return comment.toJson();
        }
        // Handle non-CommentModel case if needed
        return {};
      }).toList(),
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'hashtags': hashtags,
    };
  }
}

class CommentModel extends CommentEntity {
  const CommentModel({
    required String id,
    required String username,
    required String userProfileImageUrl,
    required String text,
    required DateTime createdAt,
    required int likesCount,
    required bool isLiked,
  }) : super(
    id: id,
    username: username,
    userProfileImageUrl: userProfileImageUrl,
    text: text,
    createdAt: createdAt,
    likesCount: likesCount,
    isLiked: isLiked,
  );

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      username: json['username'],
      userProfileImageUrl: json['userProfileImageUrl'],
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
      likesCount: json['likesCount'],
      isLiked: json['isLiked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'userProfileImageUrl': userProfileImageUrl,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'likesCount': likesCount,
      'isLiked': isLiked,
    };
  }
}