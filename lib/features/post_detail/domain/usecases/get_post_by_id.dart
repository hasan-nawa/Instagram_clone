import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';
import 'package:instagram_clone/features/post_detail/domain/repositories/post_detail_repository.dart';

class GetPostById implements UseCase<PostDetailEntity, String> {
  final PostDetailRepository repository;

  GetPostById(this.repository);

  @override
  Future<PostDetailEntity> call(String postId) {
    return repository.getPostById(postId);
  }
}