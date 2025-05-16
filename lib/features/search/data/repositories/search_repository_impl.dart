import 'package:instagram_clone/features/search/data/datasources/search_remote_data_source.dart';
import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';
import 'package:instagram_clone/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<SearchResultEntity> search(String query) async {
    return await remoteDataSource.search(query);
  }

  @override
  Future<List<PostPreviewEntity>> getExploreContent() async {
    return await remoteDataSource.getExploreContent();
  }
}