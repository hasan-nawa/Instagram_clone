import 'package:instagram_clone/features/feed/data/datasources/feed_remote_data_source.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/feed/domain/repositories/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<PostEntity>> getPosts() async {
    return await remoteDataSource.getPosts();
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
}
