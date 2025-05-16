import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadExploreContentEvent extends SearchEvent {}

class PerformSearchEvent extends SearchEvent {
  final String query;

  PerformSearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearchEvent extends SearchEvent {}