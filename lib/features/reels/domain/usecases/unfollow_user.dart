import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class UnfollowUser implements UseCase<void, String> {
  final ReelsRepository repository;

  UnfollowUser(this.repository);

  @override
  Future<void> call(String userId) {
    return repository.unfollowUser(userId);
  }
}