import 'package:equatable/equatable.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';

abstract class ActivityState extends Equatable {
  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<ActivityEntity> recentActivity;
  final List<ActivityEntity> earlierActivity;
  final bool hasLoadedEarlier;

  ActivityLoaded({
    required this.recentActivity,
    required this.earlierActivity,
    required this.hasLoadedEarlier,
  });

  @override
  List<Object> get props => [recentActivity, earlierActivity, hasLoadedEarlier];
}

class ActivityError extends ActivityState {
  final String message;

  ActivityError({required this.message});

  @override
  List<Object> get props => [message];
}