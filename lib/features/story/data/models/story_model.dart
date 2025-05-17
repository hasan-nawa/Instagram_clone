class StoryModel {
  final String id;
  final String username;
  final String userImage;
  final String storyImage;
  final bool isViewed;
  final DateTime createdAt;

  StoryModel({
    required this.id,
    required this.username,
    required this.userImage,
    required this.storyImage,
    this.isViewed = false,
    required this.createdAt,
  });

  // For demo purposes
  static List<StoryModel> getDummyStories() {
    return [
      StoryModel(
        id: '1',
        username: 'Your story',
        userImage: 'https://i.pravatar.cc/150?img=1',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: false,
        createdAt: DateTime.now(),
      ),
      StoryModel(
        id: '2',
        username: 'john_doe',
        userImage: 'https://i.pravatar.cc/150?img=2',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      StoryModel(
        id: '3',
        username: 'jane_smith',
        userImage: 'https://i.pravatar.cc/150?img=3',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      StoryModel(
        id: '4',
        username: 'alex_jones',
        userImage: 'https://i.pravatar.cc/150?img=4',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      StoryModel(
        id: '5',
        username: 'sara_connor',
        userImage: 'https://i.pravatar.cc/150?img=5',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      StoryModel(
        id: '6',
        username: 'mike_tyson',
        userImage: 'https://i.pravatar.cc/150?img=6',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: true,
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      StoryModel(
        id: '7',
        username: 'emma_watson',
        userImage: 'https://i.pravatar.cc/150?img=7',
        storyImage: 'https://picsum.photos/id/20/800/800',
        isViewed: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ];
  }
}
