import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';

abstract class PostDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoading extends PostDetailState {}

class PostDetailLoaded extends PostDetailState {
  final PostDetailEntity post;

  PostDetailLoaded({required this.post});

  @override
  List<Object> get props => [post];
}

class PostDetailError extends PostDetailState {
  final String message;

  PostDetailError({required this.message});

  @override
  List<Object> get props => [message];
}