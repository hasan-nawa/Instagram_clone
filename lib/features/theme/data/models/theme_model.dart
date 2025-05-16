import 'package:flutter/material.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends ThemeEntity {
  const ThemeModel({required super.type, required super.mode});

  factory ThemeModel.fromType(ThemeType type) {
    late ThemeMode mode;
    switch (type) {
      case ThemeType.light:
        mode = ThemeMode.light;
        break;
      case ThemeType.dark:
        mode = ThemeMode.dark;
        break;
      case ThemeType.system:
        mode = ThemeMode.system;
        break;
    }
    return ThemeModel(type: type, mode: mode);
  }

  factory ThemeModel.initial() {
    return const ThemeModel(type: ThemeType.system, mode: ThemeMode.system);
  }
}
