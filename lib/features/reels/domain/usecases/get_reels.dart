import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/repositories/reels_repository.dart';

class GetReels implements UseCase<List<ReelEntity>, NoParams> {
  final ReelsRepository repository;

  GetReels(this.repository);

  @override
  Future<List<ReelEntity>> call(NoParams params) {
    return repository.getReels();
  }
}