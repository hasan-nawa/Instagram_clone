import 'package:instagram_clone/features/post_detail/data/datasources/post_detail_remote_data_source.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class PostDetailRepositoryImpl implements PostDetailRepository {
  final PostDetailRemoteDataSource remoteDataSource;

  PostDetailRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PostDetailEntity> getPostById(String postId) async {
    return await remoteDataSource.getPostById(postId);
  }

  @override
  Future<void> likePost(String postId) async {
    await remoteDataSource.likePost(postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    await remoteDataSource.unlikePost(postId);
  }

  @override
  Future<void> bookmarkPost(String postId) async {
    await remoteDataSource.bookmarkPost(postId);
  }

  @override
  Future<void> unbookmarkPost(String postId) async {
    await remoteDataSource.unbookmarkPost(postId);
  }

  @override
  Future<void> addComment(String postId, String comment) async {
    await remoteDataSource.addComment(postId, comment);
  }

  @override
  Future<void> likeComment(String commentId) async {
    await remoteDataSource.likeComment(commentId);
  }

  @override
  Future<void> unlikeComment(String commentId) async {
    await remoteDataSource.unlikeComment(commentId);
  }
}