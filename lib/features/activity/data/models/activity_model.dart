import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';

class ActivityModel extends ActivityEntity {
  const ActivityModel({
    required String id,
    required String userId,
    required String username,
    required String userProfileImageUrl,
    required ActivityType type,
    required DateTime timestamp,
    String? relatedPostId,
    String? relatedPostImageUrl,
    String? relatedCommentText,
    required bool isRead,
  }) : super(
    id: id,
    userId: userId,
    username: username,
    userProfileImageUrl: userProfileImageUrl,
    type: type,
    timestamp: timestamp,
    relatedPostId: relatedPostId,
    relatedPostImageUrl: relatedPostImageUrl,
    relatedCommentText: relatedCommentText,
    isRead: isRead,
  );

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      userProfileImageUrl: json['userProfileImageUrl'],
      type: ActivityType.values.firstWhere(
            (e) => e.toString() == 'ActivityType.${json['type']}',
        orElse: () => ActivityType.like,
      ),
      timestamp: DateTime.parse(json['timestamp']),
      relatedPostId: json['relatedPostId'],
      relatedPostImageUrl: json['relatedPostImageUrl'],
      relatedCommentText: json['relatedCommentText'],
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userProfileImageUrl': userProfileImageUrl,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'relatedPostId': relatedPostId,
      'relatedPostImageUrl': relatedPostImageUrl,
      'relatedCommentText': relatedCommentText,
      'isRead': isRead,
    };
  }
}