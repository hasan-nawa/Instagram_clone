import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class UnlikeReel implements UseCase<void, String> {
  final ReelsRepository repository;

  UnlikeReel(this.repository);

  @override
  Future<void> call(String reelId) {
    return repository.unlikeReel(reelId);
  }
}