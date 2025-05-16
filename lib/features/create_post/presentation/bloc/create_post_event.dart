import 'package:equatable/equatable.dart';

abstract class CreatePostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ImageSelectedEvent extends CreatePostEvent {
  final String imagePath;

  ImageSelectedEvent(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class CaptionChangedEvent extends CreatePostEvent {
  final String caption;

  CaptionChangedEvent(this.caption);

  @override
  List<Object> get props => [caption];
}

class UploadPostEvent extends CreatePostEvent {}

class UpdateUploadProgressEvent extends CreatePostEvent {
  final double progress;

  UpdateUploadProgressEvent(this.progress);

  @override
  List<Object> get props => [progress];
}

class ClearCreatePostEvent extends CreatePostEvent {}

class GetHashtagSuggestionsEvent extends CreatePostEvent {
  final String text;

  GetHashtagSuggestionsEvent(this.text);

  @override
  List<Object> get props => [text];
}

class AddHashtagEvent extends CreatePostEvent {
  final String hashtag;

  AddHashtagEvent(this.hashtag);

  @override
  List<Object> get props => [hashtag];
}

class RemoveHashtagEvent extends CreatePostEvent {
  final String hashtag;

  RemoveHashtagEvent(this.hashtag);

  @override
  List<Object> get props => [hashtag];
}

class SearchUsersForMentionEvent extends CreatePostEvent {
  final String query;

  SearchUsersForMentionEvent(this.query);

  @override
  List<Object> get props => [query];
}

class AddMentionEvent extends CreatePostEvent {
  final String username;

  AddMentionEvent(this.username);

  @override
  List<Object> get props => [username];
}

class RemoveMentionEvent extends CreatePostEvent {
  final String username;

  RemoveMentionEvent(this.username);

  @override
  List<Object> get props => [username];
}