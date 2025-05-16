import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class LikePost implements UseCase<void, String> {
  final PostDetailRepository repository;

  LikePost(this.repository);

  @override
  Future<void> call(String postId) {
    return repository.likePost(postId);
  }
}