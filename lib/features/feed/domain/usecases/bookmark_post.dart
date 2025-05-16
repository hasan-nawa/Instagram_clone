import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class BookmarkPost implements UseCase<void, String> {
  final FeedRepository repository;

  BookmarkPost(this.repository);
  @override
  Future<void> call(String postId) {
    return repository.bookmarkPost(postId);
  }
}
