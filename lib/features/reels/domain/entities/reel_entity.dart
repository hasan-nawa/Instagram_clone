import 'package:equatable/equatable.dart';

class ReelEntity extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String userProfileImageUrl;
  final String videoUrl;
  final String thumbnailUrl;
  final String caption;
  final String audioName;
  final String audioOwner;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final bool isBookmarked;
  final bool isFollowing;

  const ReelEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.userProfileImageUrl,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.caption,
    required this.audioName,
    required this.audioOwner,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.isLiked,
    required this.isBookmarked,
    required this.isFollowing,
  });

  ReelEntity copyWith({
    String? id,
    String? userId,
    String? username,
    String? userProfileImageUrl,
    String? videoUrl,
    String? thumbnailUrl,
    String? caption,
    String? audioName,
    String? audioOwner,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    bool? isLiked,
    bool? isBookmarked,
    bool? isFollowing,
  }) {
    return ReelEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      caption: caption ?? this.caption,
      audioName: audioName ?? this.audioName,
      audioOwner: audioOwner ?? this.audioOwner,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object> get props => [
    id,
    userId,
    username,
    userProfileImageUrl,
    videoUrl,
    thumbnailUrl,
    caption,
    audioName,
    audioOwner,
    likesCount,
    commentsCount,
    sharesCount,
    isLiked,
    isBookmarked,
    isFollowing,
  ];
}