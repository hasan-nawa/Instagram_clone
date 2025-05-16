import 'package:instagram_clone/features/theme/data/models/theme_model.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeLocalDataSource {
  Future<ThemeModel> getTheme();
  Future<void> saveTheme(ThemeType themeType);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String themeKey = 'theme_preference';

  ThemeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ThemeModel> getTheme() async {
    final themeIndex = sharedPreferences.getInt(themeKey);
    if (themeIndex != null) {
      return ThemeModel.fromType(ThemeType.values[themeIndex]);
    } else {
      return ThemeModel.initial();
    }
  }

  @override
  Future<void> saveTheme(ThemeType themeType) async {
    await sharedPreferences.setInt(themeKey, themeType.index);
  }
}
