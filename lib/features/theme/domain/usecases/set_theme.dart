import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';
import 'package:instagram_clone/features/theme/domain/repositories/theme_repository.dart';

class SetTheme implements UseCase<void, ThemeType> {
  final ThemeRepository repository;

  SetTheme(this.repository);

  @override
  Future<void> call(ThemeType params) {
    return repository.setTheme(params);
  }
}
