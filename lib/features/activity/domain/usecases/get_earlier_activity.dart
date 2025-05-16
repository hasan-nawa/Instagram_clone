import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';
import 'package:instagram_clone/features/activity/domain/repositories/activity_repository.dart';

class GetEarlierActivity implements UseCase<List<ActivityEntity>, NoParams> {
  final ActivityRepository repository;

  GetEarlierActivity(this.repository);

  @override
  Future<List<ActivityEntity>> call(NoParams params) {
    return repository.getEarlierActivity();
  }
}