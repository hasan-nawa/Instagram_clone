import 'package:equatable/equatable.dart';

abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends NavigationEvent {
  final int index;

  ChangeTabEvent(this.index);

  @override
  List<Object> get props => [index];
}
