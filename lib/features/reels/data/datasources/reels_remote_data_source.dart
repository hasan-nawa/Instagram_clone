import 'package:instagram_clone/features/reels/data/models/reel_model.dart';

abstract class ReelsRemoteDataSource {
  Future<List<ReelModel>> getReels();
  Future<void> likeReel(String reelId);
  Future<void> unlikeReel(String reelId);
  Future<void> bookmarkReel(String reelId);
  Future<void> unbookmarkReel(String reelId);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<void> increaseShareCount(String reelId);
}

class ReelsRemoteDataSourceImpl implements ReelsRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock data

  @override
  Future<List<ReelModel>> getReels() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock reels
    return [
      ReelModel(
        id: '1',
        userId: '101',
        username: 'travel_enthusiast',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-woman-walking-through-the-city-1230-large.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1005/500/800',
        caption: 'Exploring beautiful city streets #travel #urban',
        audioName: 'City Vibes',
        audioOwner: 'Urban Tracks',
        likesCount: 1254,
        commentsCount: 42,
        sharesCount: 15,
        isLiked: false,
        isBookmarked: false,
        isFollowing: true,
      ),
      ReelModel(
        id: '2',
        userId: '102',
        username: 'food_lover',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
        videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-top-view-of-a-chopping-board-with-freshly-chopped-vegetables-10418-large.mp4',
        thumbnailUrl: 'https://picsum.photos/id/102/500/800',
        caption: 'Making the perfect salad 🥗 #food #cooking #healthyeating',
        audioName: 'Kitchen Sounds',
        audioOwner: 'Food ASMR',
        likesCount: 876,
        commentsCount: 31,
        sharesCount: 8,
        isLiked: true,
        isBookmarked: false,
        isFollowing: false,
      ),
      ReelModel(
        id: '3',
        userId: '103',
        username: 'fitness_guru',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-man-exercising-in-a-gym-with-dumbbells-5558-large.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1011/500/800',
        caption: 'Morning workout routine 💪 #fitness #workout #motivation',
        audioName: 'Workout Mix',
        audioOwner: 'Fitness Beats',
        likesCount: 2145,
        commentsCount: 78,
        sharesCount: 35,
        isLiked: false,
        isBookmarked: true,
        isFollowing: true,
      ),
      ReelModel(
        id: '4',
        userId: '104',
        username: 'nature_photographer',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-nature-view-of-a-lake-with-vegetation-in-the-water-4055-large.mp4',
        thumbnailUrl: 'https://picsum.photos/id/15/500/800',
        caption: 'The beauty of nature 🌿 #nature #photography #wilderness',
        audioName: 'Nature Sounds',
        audioOwner: 'Wild Recordings',
        likesCount: 1567,
        commentsCount: 45,
        sharesCount: 27,
        isLiked: true,
        isBookmarked: true,
        isFollowing: false,
      ),
      ReelModel(
        id: '5',
        userId: '105',
        username: 'dance_star',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
        videoUrl: 'https://assets.mixkit.co/videos/preview/mixkit-silhouette-of-a-woman-dancing-in-the-dark-4809-large.mp4',
        thumbnailUrl: 'https://picsum.photos/id/1/500/800',
        caption: 'New dance challenge! Who can do it better? #dance #challenge',
        audioName: 'Dance Hit 2025',
        audioOwner: 'Top Charts',
        likesCount: 5432,
        commentsCount: 321,
        sharesCount: 154,
        isLiked: false,
        isBookmarked: false,
        isFollowing: true,
      ),
    ];
  }

  @override
  Future<void> likeReel(String reelId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unlikeReel(String reelId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> bookmarkReel(String reelId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unbookmarkReel(String reelId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> followUser(String userId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> unfollowUser(String userId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> increaseShareCount(String reelId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
  }
}