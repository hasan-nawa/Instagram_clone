import 'package:equatable/equatable.dart';

abstract class PostDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPostDetailEvent extends PostDetailEvent {
  final String postId;

  LoadPostDetailEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}

class ToggleLikeEvent extends PostDetailEvent {}

class ToggleBookmarkEvent extends PostDetailEvent {}

class AddCommentEvent extends PostDetailEvent {
  final String comment;

  AddCommentEvent({required this.comment});

  @override
  List<Object> get props => [comment];
}