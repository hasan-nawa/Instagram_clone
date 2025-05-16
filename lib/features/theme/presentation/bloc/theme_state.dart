import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';

class ThemeState extends Equatable {
  final ThemeType themeType;
  final ThemeMode themeMode;

  const ThemeState({required this.themeType, required this.themeMode});

  factory ThemeState.initial() {
    return const ThemeState(
      themeType: ThemeType.system,
      themeMode: ThemeMode.system,
    );
  }

  @override
  List<Object> get props => [themeType, themeMode];
}
