import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class IncreaseShareCount implements UseCase<void, String> {
  final ReelsRepository repository;

  IncreaseShareCount(this.repository);

  @override
  Future<void> call(String reelId) {
    return repository.increaseShareCount(reelId);
  }
}