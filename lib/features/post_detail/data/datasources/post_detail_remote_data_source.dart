import 'package:instagram_clone/features/post_detail/data/models/post_detail_model.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';

abstract class PostDetailRemoteDataSource {
  Future<PostDetailModel> getPostById(String postId);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<void> bookmarkPost(String postId);
  Future<void> unbookmarkPost(String postId);
  Future<void> addComment(String postId, String comment);
  Future<void> likeComment(String commentId);
  Future<void> unlikeComment(String commentId);
}

class PostDetailRemoteDataSourceImpl implements PostDetailRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock data

  @override
  Future<PostDetailModel> getPostById(String postId) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return PostDetailModel(
      id: postId,
      username: 'john_doe',
      userProfileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
      imageUrl: ['https://picsum.photos/id/${int.parse(postId)}/800/800','https://picsum.photos/id/${int.parse(postId)}/800/800','https://picsum.photos/id/${int.parse(postId)}/800/800','https://picsum.photos/id/${int.parse(postId)}/800/800',],
      caption: 'Enjoying a beautiful day #nature #outdoors',
      likesCount: 1234,
      commentsCount: 123,
      comments: [
        CommentModel(
          id: '1',
          username: 'jane_smith',
          userProfileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
          text: 'This is amazing! 😍',
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          likesCount: 42,
          isLiked: false,
        ),
        CommentModel(
          id: '2',
          username: 'travel_enthusiast',
          userProfileImageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
          text: 'Wow, what a view!',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          likesCount: 18,
          isLiked: true,
        ),
        CommentModel(
          id: '3',
          username: 'photo_lover',
          userProfileImageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
          text: 'Great shot, what camera did you use?',
          createdAt: DateTime.now().subtract(const Duration(hours: 8)),
          likesCount: 7,
          isLiked: false,
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(hours: 10)),
      isLiked: postId.hashCode % 2 == 0, // Random like status based on postId
      isBookmarked: postId.hashCode % 3 == 0, // Random bookmark status based on postId
      hashtags: ['nature', 'outdoors'],
    );
  }

  @override
  Future<void> likePost(String postId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> unlikePost(String postId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> bookmarkPost(String postId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> unbookmarkPost(String postId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> addComment(String postId, String comment) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> likeComment(String commentId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> unlikeComment(String commentId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }
}