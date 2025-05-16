import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class BookmarkReel implements UseCase<void, String> {
  final ReelsRepository repository;

  BookmarkReel(this.repository);

  @override
  Future<void> call(String reelId) {
    return repository.bookmarkReel(reelId);
  }
}