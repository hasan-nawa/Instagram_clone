import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';
import 'package:instagram_clone/features/search/domain/repositories/search_repository.dart';

class Search implements UseCase<SearchResultEntity, String> {
  final SearchRepository repository;

  Search(this.repository);

  @override
  Future<SearchResultEntity> call(String query) {
    return repository.search(query);
  }
}