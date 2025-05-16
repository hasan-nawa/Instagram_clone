import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/profile/domain/repositories/profile_repository.dart';

class FollowUser implements UseCase<void, String> {
  final ProfileRepository repository;

  FollowUser(this.repository);

  @override
  Future<void> call(String username) {
    return repository.followUser(username);
  }
}