import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadThemeEvent extends ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class SetLightThemeEvent extends ThemeEvent {}

class SetDarkThemeEvent extends ThemeEvent {}

class UseSystemThemeEvent extends ThemeEvent {}
