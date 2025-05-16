import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class FollowUser implements UseCase<void, String> {
  final ReelsRepository repository;

  FollowUser(this.repository);

  @override
  Future<void> call(String userId) {
    return repository.followUser(userId);
  }
}