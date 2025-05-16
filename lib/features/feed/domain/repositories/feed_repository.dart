import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';

abstract class FeedRepository {
  Future<List<PostEntity>> getPosts();
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<void> bookmarkPost(String postId);
  Future<void> unbookmarkPost(String postId);
}
