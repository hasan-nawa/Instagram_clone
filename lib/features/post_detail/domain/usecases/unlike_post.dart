import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class UnlikePost implements UseCase<void, String> {
  final PostDetailRepository repository;

  UnlikePost(this.repository);

  @override
  Future<void> call(String postId) {
    return repository.unlikePost(postId);
  }
}