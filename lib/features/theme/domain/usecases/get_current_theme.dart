import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';
import 'package:instagram_clone/features/theme/domain/repositories/theme_repository.dart';

class GetCurrentTheme implements UseCase<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetCurrentTheme(this.repository);

  @override
  Future<ThemeEntity> call(NoParams params) {
    return repository.getCurrentTheme();
  }
}
