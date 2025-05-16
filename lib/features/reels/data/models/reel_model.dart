import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';

class ReelModel extends ReelEntity {
  const ReelModel({
    required String id,
    required String userId,
    required String username,
    required String userProfileImageUrl,
    required String videoUrl,
    required String thumbnailUrl,
    required String caption,
    required String audioName,
    required String audioOwner,
    required int likesCount,
    required int commentsCount,
    required int sharesCount,
    required bool isLiked,
    required bool isBookmarked,
    required bool isFollowing,
  }) : super(
    id: id,
    userId: userId,
    username: username,
    userProfileImageUrl: userProfileImageUrl,
    videoUrl: videoUrl,
    thumbnailUrl: thumbnailUrl,
    caption: caption,
    audioName: audioName,
    audioOwner: audioOwner,
    likesCount: likesCount,
    commentsCount: commentsCount,
    sharesCount: sharesCount,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    isFollowing: isFollowing,
  );

  factory ReelModel.fromJson(Map<String, dynamic> json) {
    return ReelModel(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      userProfileImageUrl: json['userProfileImageUrl'],
      videoUrl: json['videoUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      caption: json['caption'],
      audioName: json['audioName'],
      audioOwner: json['audioOwner'],
      likesCount: json['likesCount'],
      commentsCount: json['commentsCount'],
      sharesCount: json['sharesCount'],
      isLiked: json['isLiked'],
      isBookmarked: json['isBookmarked'],
      isFollowing: json['isFollowing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userProfileImageUrl': userProfileImageUrl,
      'videoUrl': videoUrl,
      'thumbnailUrl': thumbnailUrl,
      'caption': caption,
      'audioName': audioName,
      'audioOwner': audioOwner,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
      'isFollowing': isFollowing,
    };
  }
}