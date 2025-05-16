import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';

class CreatePost implements UseCase<void, CreatePostEntity> {
  final CreatePostRepository repository;

  CreatePost(this.repository);

  @override
  Future<void> call(CreatePostEntity post) {
    return repository.createPost(post);
  }
}