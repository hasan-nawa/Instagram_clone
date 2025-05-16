import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class UnlikePost implements UseCase<void, String> {
  final FeedRepository repository;

  UnlikePost(this.repository);

  @override
  Future<void> call(String postId) {
    return repository.unlikePost(postId);
  }
}
