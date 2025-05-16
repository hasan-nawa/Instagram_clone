import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class UnbookmarkPost implements UseCase<void, String> {
  final FeedRepository repository;

  UnbookmarkPost(this.repository);
  @override
  Future<void> call(String postId) {
    return repository.unbookmarkPost(postId);
  }
}
