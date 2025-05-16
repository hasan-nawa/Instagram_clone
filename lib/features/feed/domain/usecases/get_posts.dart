import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class GetPosts implements UseCase<List<PostEntity>, NoParams> {
  final FeedRepository repository;

  GetPosts(this.repository);

  @override
  Future<List<PostEntity>> call(NoParams params) {
    return repository.getPosts();
  }
}
