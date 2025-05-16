import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';

abstract class SearchRepository {
  Future<SearchResultEntity> search(String query);
  Future<List<PostPreviewEntity>> getExploreContent();
}