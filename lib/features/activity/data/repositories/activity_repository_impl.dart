import 'package:instagram_clone/features/activity/data/datasources/activity_remote_data_source.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';
import 'package:instagram_clone/features/activity/domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityRemoteDataSource remoteDataSource;

  ActivityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActivityEntity>> getRecentActivity() async {
    return await remoteDataSource.getRecentActivity();
  }

  @override
  Future<List<ActivityEntity>> getEarlierActivity() async {
    return await remoteDataSource.getEarlierActivity();
  }

  @override
  Future<void> markAsRead(String activityId) async {
    await remoteDataSource.markAsRead(activityId);
  }

  @override
  Future<void> markAllAsRead() async {
    await remoteDataSource.markAllAsRead();
  }
}