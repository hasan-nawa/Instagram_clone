import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/profile/domain/repositories/profile_repository.dart';

class UnfollowUser implements UseCase<void, String> {
  final ProfileRepository repository;

  UnfollowUser(this.repository);

  @override
  Future<void> call(String username) {
    return repository.unfollowUser(username);
  }
}