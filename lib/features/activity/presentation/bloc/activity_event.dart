import 'package:equatable/equatable.dart';

abstract class ActivityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRecentActivityEvent extends ActivityEvent {}

class LoadEarlierActivityEvent extends ActivityEvent {}

class MarkActivityAsReadEvent extends ActivityEvent {
  final String activityId;

  MarkActivityAsReadEvent({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class MarkAllActivityAsReadEvent extends ActivityEvent {}