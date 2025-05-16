import 'package:instagram_clone/features/search/data/models/search_result_model.dart';
import 'package:instagram_clone/features/search/domain/entities/search_result_entity.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResultModel> search(String query);
  Future<List<PostPreviewEntity>> getExploreContent();
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock data

  @override
  Future<SearchResultModel> search(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate mock search results based on query
    return SearchResultModel(
      users: [
        UserModel(
          id: '1',
          username: '${query}_user1',
          fullName: 'User One with $query',
          profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
          isVerified: true,
          isFollowing: false,
        ),
        UserModel(
          id: '2',
          username: '${query}_user2',
          fullName: 'User Two with $query',
          profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
          isVerified: false,
          isFollowing: true,
        ),
        UserModel(
          id: '3',
          username: '${query}_enthusiast',
          fullName: 'Enthusiast of $query',
          profileImageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
          isVerified: false,
          isFollowing: false,
        ),
      ],
      hashtags: [
        HashtagModel(
          name: query,
          postsCount: 12345,
        ),
        HashtagModel(
          name: '${query}love',
          postsCount: 5678,
        ),
        HashtagModel(
          name: '${query}photography',
          postsCount: 9012,
        ),
      ],
      topPosts: List.generate(
        9,
            (index) => PostPreviewModel(
          id: (index + 1).toString(),
          imageUrl: 'https://picsum.photos/id/${(index * 10) + 1}/300/300',
          likesCount: (index + 1) * 100,
          commentsCount: (index + 1) * 10,
        ),
      ),
    );
  }

  @override
  Future<List<PostPreviewEntity>> getExploreContent() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate mock explore content
    return List.generate(
      24,
          (index) => PostPreviewModel(
        id: (index + 1).toString(),
        imageUrl: 'https://picsum.photos/id/${(index * 5) + 1}/300/300',
        likesCount: (index + 1) * 100,
        commentsCount: (index + 1) * 10,
      ),
    );
  }
}