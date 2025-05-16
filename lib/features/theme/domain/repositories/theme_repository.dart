import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';

abstract class ThemeRepository {
  Future<ThemeEntity> getCurrentTheme();
  Future<void> setTheme(ThemeType themeType);
}
