import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/profile/domain/entities/profile_entity.dart';
import 'package:instagram_clone/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfile implements UseCase<ProfileEntity, String> {
  final ProfileRepository repository;

  GetUserProfile(this.repository);

  @override
  Future<ProfileEntity> call(String username) {
    return repository.getUserProfile(username);
  }
}