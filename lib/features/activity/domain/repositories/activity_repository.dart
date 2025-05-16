import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';

abstract class ActivityRepository {
  Future<List<ActivityEntity>> getRecentActivity();
  Future<List<ActivityEntity>> getEarlierActivity();
  Future<void> markAsRead(String activityId);
  Future<void> markAllAsRead();
}