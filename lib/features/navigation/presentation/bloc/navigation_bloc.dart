import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_event.dart';
import 'package:instagram_clone/features/navigation/presentation/bloc/navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(currentIndex: 0)) {
    on<ChangeTabEvent>(_onChangeTab);
  }

  void _onChangeTab(ChangeTabEvent event, Emitter<NavigationState> emit) {
    emit(NavigationState(currentIndex: event.index));
  }
}
