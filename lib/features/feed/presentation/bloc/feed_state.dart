import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/api_call_status.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedInitial extends BaseApiState {
  @override
  MyApiStatus toApiStatus() => Holding();
}

final class FeedLoading extends BaseApiState {
  @override
  MyApiStatus toApiStatus() => Loading();
}

class FeedLoaded extends BaseApiState {
  final List<PostEntity> posts;

  FeedLoaded({required this.posts});

  @override
  MyApiStatus toApiStatus() => Success();

  @override
  List<Object> get props => [posts];
}

class FeedError extends BaseApiState {
  final String message;

  FeedError({required this.message});

  @override
  MyApiStatus toApiStatus() => Error(message: message);

  @override
  List<Object> get props => [message];
}
