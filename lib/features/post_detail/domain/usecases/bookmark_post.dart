import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class BookmarkPost implements UseCase<void, String> {
  final PostDetailRepository repository;

  BookmarkPost(this.repository);

  @override
  Future<void> call(String postId) {
    return repository.bookmarkPost(postId);
  }
}