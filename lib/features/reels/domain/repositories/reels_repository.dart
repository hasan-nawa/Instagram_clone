import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';

abstract class ReelsRepository {
  Future<List<ReelEntity>> getReels();
  Future<void> likeReel(String reelId);
  Future<void> unlikeReel(String reelId);
  Future<void> bookmarkReel(String reelId);
  Future<void> unbookmarkReel(String reelId);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<void> increaseShareCount(String reelId);
}