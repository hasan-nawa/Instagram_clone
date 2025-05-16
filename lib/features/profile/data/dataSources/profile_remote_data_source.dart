import 'package:instagram_clone/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getUserProfile(String username);
  Future<void> followUser(String username);
  Future<void> unfollowUser(String username);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {


  @override
  Future<ProfileModel> getUserProfile(String username) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Mock current user profile
    if (username == 'current_user' || username.isEmpty) {
      return ProfileModel(
        username: 'john_doe',
        fullName: 'John Doe',
        profileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        bio: 'Flutter Developer | Photography Enthusiast | Coffee Lover',
        postsCount: 42,
        followersCount: 1234,
        followingCount: 567,
        postImageUrls: List.generate(
            12,
                (index) => 'https://picsum.photos/id/${10 + index}/300/300'
        ),
        isCurrentUser: true,
      );
    }

    // Mock another user profile
    return ProfileModel(
      username: username,
      fullName: 'Jane Smith',
      profileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      bio: 'Travel | Food | Lifestyle',
      postsCount: 36,
      followersCount: 2456,
      followingCount: 876,
      postImageUrls: List.generate(
          9,
              (index) => 'https://picsum.photos/id/${20 + index}/300/300'
      ),
      isCurrentUser: false,
    );
  }

  @override
  Future<void> followUser(String username) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, we would make an API call here
  }

  @override
  Future<void> unfollowUser(String username) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, we would make an API call here
  }
}