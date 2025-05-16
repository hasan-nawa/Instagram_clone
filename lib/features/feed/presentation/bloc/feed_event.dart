import 'package:equatable/equatable.dart';

sealed class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object> get props => [];
}

class LoadFeedEvent extends FeedEvent {}

class RefreshFeedEvent extends FeedEvent {}

class ToggleLikeEvent extends FeedEvent {
  final String postId;
  final bool isLiked;

  const ToggleLikeEvent({required this.postId, required this.isLiked});

  @override
  List<Object> get props => [postId, isLiked];
}

class ToggleBookmarkEvent extends FeedEvent {
  final String postId;
  final bool isBookmarked;

  const ToggleBookmarkEvent({required this.postId, required this.isBookmarked});

  @override
  List<Object> get props => [postId, isBookmarked];
}
