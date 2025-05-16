import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';
import 'package:instagram_clone/features/search/domain/repositories/search_repository.dart';

class GetExploreContent implements UseCase<List<PostPreviewEntity>, NoParams> {
  final SearchRepository repository;

  GetExploreContent(this.repository);

  @override
  Future<List<PostPreviewEntity>> call(NoParams params) {
    return repository.getExploreContent();
  }
}