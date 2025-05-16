import 'package:instagram_clone/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';
import 'package:instagram_clone/features/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl({required this.localDataSource});

  @override
  Future<ThemeEntity> getCurrentTheme() async {
    return await localDataSource.getTheme();
  }

  @override
  Future<void> setTheme(ThemeType themeType) async {
    await localDataSource.saveTheme(themeType);
  }
}
