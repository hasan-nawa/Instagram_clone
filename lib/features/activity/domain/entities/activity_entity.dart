import 'package:equatable/equatable.dart';

enum ActivityType {
  like,
  comment,
  follow,
  mention,
  followRequest,
  suggestedUser,
  postUpdate
}

class ActivityEntity extends Equatable {
  final String id;
  final String userId;
  final String username;
  final String userProfileImageUrl;
  final ActivityType type;
  final DateTime timestamp;
  final String? relatedPostId;
  final String? relatedPostImageUrl;
  final String? relatedCommentText;
  final bool isRead;

  const ActivityEntity({
    required this.id,
    required this.userId,
    required this.username,
    required this.userProfileImageUrl,
    required this.type,
    required this.timestamp,
    this.relatedPostId,
    this.relatedPostImageUrl,
    this.relatedCommentText,
    required this.isRead,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    username,
    userProfileImageUrl,
    type,
    timestamp,
    relatedPostId,
    relatedPostImageUrl,
    relatedCommentText,
    isRead,
  ];
}