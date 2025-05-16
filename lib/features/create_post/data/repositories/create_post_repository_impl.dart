import 'dart:io';
import 'package:instagram_clone/features/create_post/data/datasources/create_post_remote_data_source.dart';
import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';

class CreatePostRepositoryImpl implements CreatePostRepository {
  final CreatePostRemoteDataSource remoteDataSource;

  CreatePostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> uploadImage(File image, Function(double) onProgress) async {
    return await remoteDataSource.uploadImage(image, onProgress);
  }

  @override
  Future<void> createPost(CreatePostEntity post) async {
    await remoteDataSource.createPost(post);
  }

  @override
  Future<List<String>> getSuggestedHashtags(String text) async {
    return await remoteDataSource.getSuggestedHashtags(text);
  }

  @override
  Future<List<String>> searchUsers(String query) async {
    return await remoteDataSource.searchUsers(query);
  }
}