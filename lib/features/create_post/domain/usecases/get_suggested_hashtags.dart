import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';

class GetSuggestedHashtags implements UseCase<List<String>, String> {
  final CreatePostRepository repository;

  GetSuggestedHashtags(this.repository);

  @override
  Future<List<String>> call(String text) {
    return repository.getSuggestedHashtags(text);
  }
}