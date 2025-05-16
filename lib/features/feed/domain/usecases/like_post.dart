import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class LikePost implements UseCase<void, String> {
  final FeedRepository repository;
  LikePost(this.repository);

  @override
  Future<void> call(String postId) => repository.likePost(postId);
}
