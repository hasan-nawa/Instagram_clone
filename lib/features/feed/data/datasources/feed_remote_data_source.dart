import 'package:instagram_clone/features/feed/data/models/post_model.dart';

abstract class FeedRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<void> bookmarkPost(String postId);
  Future<void> unbookmarkPost(String postId);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock data

  @override
  Future<List<PostModel>> getPosts() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Return mock data
    return [
      PostModel(
        id: '1',
        username: 'john_doe',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        imageUrl: ['https://picsum.photos/id/1/800/800','https://picsum.photos/id/1/800/800','https://picsum.photos/id/1/800/800','https://picsum.photos/id/1/800/800',],
        caption: "🌿 Some days are for thriving, others are just for surviving — and both are perfectly okay. Over the past few months, I’ve learned that growth doesn’t always look like bold steps forward. Sometimes it’s about showing up, staying kind, and being patient with yourself. This journey has had its highs and lows, but I’ve found beauty in the slow parts too. Here’s to trusting the process, honoring where you are, and celebrating even the quiet wins. 🌞",
        likesCount: 1234,
        commentsCount: 56,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        isLiked: false,
        isBookmarked: false,
        hashtags: ['nature', 'outdoors'],
      ),
      PostModel(
        id: '2',
        username: 'jane_smith',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
        imageUrl: ['https://picsum.photos/id/20/800/800','https://picsum.photos/id/20/800/800','https://picsum.photos/id/20/800/800','https://picsum.photos/id/20/800/800','https://picsum.photos/id/20/800/800',],
        caption: "There’s something magical about moments that weren’t planned — the laughter that just happens, the peace in stillness, and the way a single snapshot can hold so much emotion. This photo wasn’t staged, but it holds a piece of my heart. Real life, raw feelings, and honest memories — those are the ones I keep close. Grateful for the people and places that remind me to slow down and simply be. 💛 #InTheMoment #GratefulHeart #AuthenticLiving",
        likesCount: 853,
        commentsCount: 42,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        isLiked: true,
        isBookmarked: true,
        hashtags: ['coffee', 'mornings'],
      ),
      PostModel(
        id: '3',
        username: 'travel_enthusiast',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        imageUrl: ['https://picsum.photos/id/30/800/800','https://picsum.photos/id/30/800/800','https://picsum.photos/id/30/800/800','https://picsum.photos/id/30/800/800','https://picsum.photos/id/30/800/800'],
        caption: "Here’s the thing: you don’t grow where it’s comfortable. You grow when you take the risk, make the leap, and challenge yourself to go a little further than yesterday. This season has been full of stretching and learning — and yeah, some fear too. But I’ve found courage in community, strength in stillness, and clarity in the unknown. So here’s to every moment that pushes us forward — ready or not. 🚀",
        likesCount: 2587,
        commentsCount: 124,
        createdAt: DateTime.now().subtract(const Duration(hours: 8)),
        isLiked: false,
        isBookmarked: true,
        hashtags: ['travel', 'adventure'],
      ),
      PostModel(
        id: '4',
        username: 'foodie_central',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        imageUrl: ['https://picsum.photos/id/40/800/800','https://picsum.photos/id/40/800/800','https://picsum.photos/id/40/800/800','https://picsum.photos/id/40/800/800','https://picsum.photos/id/40/800/800'],
        caption: 'Homemade pasta 🍝 #food #cooking #homemade',
        likesCount: 976,
        commentsCount: 63,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        isLiked: true,
        isBookmarked: false,
        hashtags: ['food', 'cooking', 'homemade'],
      ),
    ];
  }

  @override
  Future<void> likePost(String postId) async {
    // In a real app, this would call an API endpoint
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unlikePost(String postId) async {
    // In a real app, this would call an API endpoint
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> bookmarkPost(String postId) async {
    // In a real app, this would call an API endpoint
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> unbookmarkPost(String postId) async {
    // In a real app, this would call an API endpoint
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
