import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/create_post/domain/repositories/create_post_repository.dart';

class UploadImageParams extends Equatable {
  final File image;
  final Function(double) onProgress;

  const UploadImageParams({
    required this.image,
    required this.onProgress,
  });

  @override
  List<Object> get props => [image];
}

class UploadImage implements UseCase<String, UploadImageParams> {
  final CreatePostRepository repository;

  UploadImage(this.repository);

  @override
  Future<String> call(UploadImageParams params) {
    return repository.uploadImage(params.image, params.onProgress);
  }
}