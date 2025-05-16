import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/activity/domain/repositories/activity_repository.dart';

class MarkAllAsRead implements UseCase<void, NoParams> {
  final ActivityRepository repository;

  MarkAllAsRead(this.repository);

  @override
  Future<void> call(NoParams params) {
    return repository.markAllAsRead();
  }
}