import 'package:instagram_clone/features/create_post/domain/entities/create_post_entity.dart';

class CreatePostModel extends CreatePostEntity {
  const CreatePostModel({
    String? imagePath,
    String caption = '',
    List<String> hashtags = const [],
    List<String> mentionedUsers = const [],
    bool isUploading = false,
    double uploadProgress = 0.0,
    bool isSuccess = false,
    String? errorMessage,
  }) : super(
    imagePath: imagePath,
    caption: caption,
    hashtags: hashtags,
    mentionedUsers: mentionedUsers,
    isUploading: isUploading,
    uploadProgress: uploadProgress,
    isSuccess: isSuccess,
    errorMessage: errorMessage,
  );

  factory CreatePostModel.fromJson(Map<String, dynamic> json) {
    return CreatePostModel(
      imagePath: json['imagePath'],
      caption: json['caption'],
      hashtags: List<String>.from(json['hashtags']),
      mentionedUsers: List<String>.from(json['mentionedUsers']),
      isUploading: json['isUploading'],
      uploadProgress: json['uploadProgress'],
      isSuccess: json['isSuccess'],
      errorMessage: json['errorMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'caption': caption,
      'hashtags': hashtags,
      'mentionedUsers': mentionedUsers,
      'isUploading': isUploading,
      'uploadProgress': uploadProgress,
      'isSuccess': isSuccess,
      'errorMessage': errorMessage,
    };
  }
}