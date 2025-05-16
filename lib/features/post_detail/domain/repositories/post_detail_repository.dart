import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';

abstract class PostDetailRepository {
  Future<PostDetailEntity> getPostById(String postId);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<void> bookmarkPost(String postId);
  Future<void> unbookmarkPost(String postId);
  Future<void> addComment(String postId, String comment);
  Future<void> likeComment(String commentId);
  Future<void> unlikeComment(String commentId);
}