import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';

class SearchUsers implements UseCase<List<String>, String> {
  final CreatePostRepository repository;

  SearchUsers(this.repository);

  @override
  Future<List<String>> call(String query) {
    return repository.searchUsers(query);
  }
}