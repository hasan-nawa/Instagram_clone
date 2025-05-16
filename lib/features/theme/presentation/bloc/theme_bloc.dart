import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/theme/domain/entities/theme_entity.dart';
import 'package:instagram_clone/features/theme/domain/usecases/get_current_theme.dart';
import 'package:instagram_clone/features/theme/domain/usecases/set_theme.dart';
import 'package:instagram_clone/features/theme/presentation/bloc/theme_event.dart';
import 'package:instagram_clone/features/theme/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetCurrentTheme getCurrentTheme;
  final SetTheme setTheme;

  ThemeBloc({required this.getCurrentTheme, required this.setTheme})
    : super(ThemeState.initial()) {
    on<ToggleThemeEvent>(_onToggleTheme);
    on<SetLightThemeEvent>(_onSetLightTheme);
    on<SetDarkThemeEvent>(_onSetDarkTheme);
    on<UseSystemThemeEvent>(_onUseSystemTheme);
    on<LoadThemeEvent>(_onLoadTheme);

    // Load saved theme when bloc is created
    add(LoadThemeEvent());
  }

  void _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final themeEntity = await getCurrentTheme(NoParams());
    emit(ThemeState(themeType: themeEntity.type, themeMode: themeEntity.mode));
  }

  void _onToggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) async {
    final newThemeType =
        state.themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;

    await setTheme(newThemeType);
    final themeEntity = await getCurrentTheme(NoParams());

    emit(ThemeState(themeType: themeEntity.type, themeMode: themeEntity.mode));
  }

  void _onSetLightTheme(
    SetLightThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await setTheme(ThemeType.light);
    final themeEntity = await getCurrentTheme(NoParams());

    emit(ThemeState(themeType: themeEntity.type, themeMode: themeEntity.mode));
  }

  void _onSetDarkTheme(
    SetDarkThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await setTheme(ThemeType.dark);
    final themeEntity = await getCurrentTheme(NoParams());

    emit(ThemeState(themeType: themeEntity.type, themeMode: themeEntity.mode));
  }

  void _onUseSystemTheme(
    UseSystemThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    await setTheme(ThemeType.system);
    final themeEntity = await getCurrentTheme(NoParams());

    emit(ThemeState(themeType: themeEntity.type, themeMode: themeEntity.mode));
  }
}
