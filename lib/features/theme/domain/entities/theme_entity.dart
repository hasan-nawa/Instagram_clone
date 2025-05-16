import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeType { light, dark, system }

class ThemeEntity extends Equatable {
  final ThemeType type;
  final ThemeMode mode;

  const ThemeEntity({required this.type, required this.mode});

  @override
  List<Object> get props => [type, mode];
}
