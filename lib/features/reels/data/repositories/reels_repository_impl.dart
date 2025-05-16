import 'package:instagram_clone/features/reels/data/datasources/reels_remote_data_source.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class ReelsRepositoryImpl implements ReelsRepository {
  final ReelsRemoteDataSource remoteDataSource;

  ReelsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ReelEntity>> getReels() async {
    return await remoteDataSource.getReels();
  }

  @override
  Future<void> likeReel(String reelId) async {
    await remoteDataSource.likeReel(reelId);
  }

  @override
  Future<void> unlikeReel(String reelId) async {
    await remoteDataSource.unlikeReel(reelId);
  }

  @override
  Future<void> bookmarkReel(String reelId) async {
    await remoteDataSource.bookmarkReel(reelId);
  }

  @override
  Future<void> unbookmarkReel(String reelId) async {
    await remoteDataSource.unbookmarkReel(reelId);
  }

  @override
  Future<void> followUser(String userId) async {
    await remoteDataSource.followUser(userId);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await remoteDataSource.unfollowUser(userId);
  }

  @override
  Future<void> increaseShareCount(String reelId) async {
    await remoteDataSource.increaseShareCount(reelId);
  }
}