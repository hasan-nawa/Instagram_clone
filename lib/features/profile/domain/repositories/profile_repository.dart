import 'package:instagram_clone/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUserProfile(String username);
  Future<void> followUser(String username);
  Future<void> unfollowUser(String username);
}