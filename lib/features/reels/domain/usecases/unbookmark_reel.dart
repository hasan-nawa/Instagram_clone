import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class UnbookmarkReel implements UseCase<void, String> {
  final ReelsRepository repository;

  UnbookmarkReel(this.repository);

  @override
  Future<void> call(String reelId) {
    return repository.unbookmarkReel(reelId);
  }
}