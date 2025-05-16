import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class LikeReel implements UseCase<void, String> {
  final ReelsRepository repository;

  LikeReel(this.repository);

  @override
  Future<void> call(String reelId) {
    return repository.likeReel(reelId);
  }
}