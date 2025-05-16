import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/activity/domain/repositories/activity_repository.dart';

class MarkAsRead implements UseCase<void, String> {
  final ActivityRepository repository;

  MarkAsRead(this.repository);

  @override
  Future<void> call(String activityId) {
    return repository.markAsRead(activityId);
  }
}