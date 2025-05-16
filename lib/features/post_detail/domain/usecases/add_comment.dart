import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class AddCommentParams extends Equatable {
  final String postId;
  final String comment;

  const AddCommentParams({
    required this.postId,
    required this.comment,
  });

  @override
  List<Object> get props => [postId, comment];
}

class AddComment implements UseCase<void, AddCommentParams> {
  final PostDetailRepository repository;

  AddComment(this.repository);

  @override
  Future<void> call(AddCommentParams params) {
    return repository.addComment(params.postId, params.comment);
  }
}