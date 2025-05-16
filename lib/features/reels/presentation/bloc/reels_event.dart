import 'package:equatable/equatable.dart';

abstract class ReelsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadReelsEvent extends ReelsEvent {}

class ToggleLikeEvent extends ReelsEvent {
  final String reelId;
  final bool isLiked;

  ToggleLikeEvent({
    required this.reelId,
    required this.isLiked,
  });

  @override
  List<Object> get props => [reelId, isLiked];
}

class ToggleBookmarkEvent extends ReelsEvent {
  final String reelId;
  final bool isBookmarked;

  ToggleBookmarkEvent({
    required this.reelId,
    required this.isBookmarked,
  });

  @override
  List<Object> get props => [reelId, isBookmarked];
}

class ToggleFollowEvent extends ReelsEvent {
  final String userId;
  final bool isFollowing;

  ToggleFollowEvent({
    required this.userId,
    required this.isFollowing,
  });

  @override
  List<Object> get props => [userId, isFollowing];
}

class ShareReelEvent extends ReelsEvent {
  final String reelId;

  ShareReelEvent({required this.reelId});

  @override
  List<Object> get props => [reelId];
}

class ChangeCurrentReelEvent extends ReelsEvent {
  final int index;

  ChangeCurrentReelEvent({required this.index});

  @override
  List<Object> get props => [index];
}