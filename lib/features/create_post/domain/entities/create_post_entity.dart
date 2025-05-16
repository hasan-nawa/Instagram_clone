import 'package:equatable/equatable.dart';

class CreatePostEntity extends Equatable {
  final String? imagePath;
  final String caption;
  final List<String> hashtags;
  final List<String> mentionedUsers;
  final bool isUploading;
  final double uploadProgress;
  final bool isSuccess;
  final String? errorMessage;

  const CreatePostEntity({
    this.imagePath,
    this.caption = '',
    this.hashtags = const [],
    this.mentionedUsers = const [],
    this.isUploading = false,
    this.uploadProgress = 0.0,
    this.isSuccess = false,
    this.errorMessage,
  });

  CreatePostEntity copyWith({
    String? imagePath,
    String? caption,
    List<String>? hashtags,
    List<String>? mentionedUsers,
    bool? isUploading,
    double? uploadProgress,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return CreatePostEntity(
      imagePath: imagePath ?? this.imagePath,
      caption: caption ?? this.caption,
      hashtags: hashtags ?? this.hashtags,
      mentionedUsers: mentionedUsers ?? this.mentionedUsers,
      isUploading: isUploading ?? this.isUploading,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    imagePath,
    caption,
    hashtags,
    mentionedUsers,
    isUploading,
    uploadProgress,
    isSuccess,
    errorMessage,
  ];
}