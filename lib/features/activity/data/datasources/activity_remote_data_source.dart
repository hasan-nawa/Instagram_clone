import 'package:instagram_clone/features/activity/data/models/activity_model.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';

abstract class ActivityRemoteDataSource {
  Future<List<ActivityModel>> getRecentActivity();
  Future<List<ActivityModel>> getEarlierActivity();
  Future<void> markAsRead(String activityId);
  Future<void> markAllAsRead();
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  // In a real app, this would be an API client
  // For now, we'll use mock data

  @override
  Future<List<ActivityModel>> getRecentActivity() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate mock recent activity
    return [
      ActivityModel(
        id: '1',
        userId: '101',
        username: 'jane_smith',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        type: ActivityType.like,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        relatedPostId: '201',
        relatedPostImageUrl: 'https://picsum.photos/id/237/300/300',
        isRead: false,
      ),
      ActivityModel(
        id: '2',
        userId: '102',
        username: 'photo_enthusiast',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
        type: ActivityType.comment,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        relatedPostId: '202',
        relatedPostImageUrl: 'https://picsum.photos/id/238/300/300',
        relatedCommentText: 'Amazing shot! What camera did you use?',
        isRead: false,
      ),
      ActivityModel(
        id: '3',
        userId: '103',
        username: 'travel_lover',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        type: ActivityType.follow,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        isRead: true,
      ),
      ActivityModel(
        id: '4',
        userId: '104',
        username: 'fitness_guru',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        type: ActivityType.mention,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        relatedPostId: '203',
        relatedPostImageUrl: 'https://picsum.photos/id/239/300/300',
        relatedCommentText: 'Check out this workout by @john_doe',
        isRead: false,
      ),
    ];
  }

  @override
  Future<List<ActivityModel>> getEarlierActivity() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate mock earlier activity
    return [
      ActivityModel(
        id: '5',
        userId: '105',
        username: 'foodie_central',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/5.jpg',
        type: ActivityType.like,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        relatedPostId: '204',
        relatedPostImageUrl: 'https://picsum.photos/id/240/300/300',
        isRead: true,
      ),
      ActivityModel(
        id: '6',
        userId: '106',
        username: 'art_lover',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/6.jpg',
        type: ActivityType.comment,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 4)),
        relatedPostId: '205',
        relatedPostImageUrl: 'https://picsum.photos/id/241/300/300',
        relatedCommentText: 'Beautiful composition!',
        isRead: true,
      ),
      ActivityModel(
        id: '7',
        userId: '107',
        username: 'tech_enthusiast',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/7.jpg',
        type: ActivityType.follow,
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 10)),
        isRead: true,
      ),
      ActivityModel(
        id: '8',
        userId: '108',
        username: 'music_lover',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/men/8.jpg',
        type: ActivityType.followRequest,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        isRead: true,
      ),
      ActivityModel(
        id: '9',
        userId: '109',
        username: 'nature_photographer',
        userProfileImageUrl: 'https://randomuser.me/api/portraits/women/9.jpg',
        type: ActivityType.suggestedUser,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
      ),
    ];
  }

  @override
  Future<void> markAsRead(String activityId) async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real app, this would call an API endpoint
  }

  @override
  Future<void> markAllAsRead() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call an API endpoint
  }
}