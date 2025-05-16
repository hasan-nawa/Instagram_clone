import 'dart:io';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';

abstract class CreatePostRepository {
  Future<String> uploadImage(File image, Function(double) onProgress);
  Future<void> createPost(CreatePostEntity post);
  Future<List<String>> getSuggestedHashtags(String text);
  Future<List<String>> searchUsers(String query);
}