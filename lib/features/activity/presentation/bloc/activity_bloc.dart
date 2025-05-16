import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';
import 'package:instagram_clone/features/activity/domain/usecases/get_earlier_activity.dart';
import 'package:instagram_clone/features/activity/domain/usecases/get_recent_activity.dart';
import 'package:instagram_clone/features/activity/domain/usecases/mark_all_as_read.dart';
import 'package:instagram_clone/features/activity/domain/usecases/mark_as_read.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_event.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetRecentActivity getRecentActivity;
  final GetEarlierActivity getEarlierActivity;
  final MarkAsRead markAsRead;
  final MarkAllAsRead markAllAsRead;

  ActivityBloc({
    required this.getRecentActivity,
    required this.getEarlierActivity,
    required this.markAsRead,
    required this.markAllAsRead,
  }) : super(ActivityInitial()) {
    on<LoadRecentActivityEvent>(_onLoadRecentActivity);
    on<LoadEarlierActivityEvent>(_onLoadEarlierActivity);
    on<MarkActivityAsReadEvent>(_onMarkActivityAsRead);
    on<MarkAllActivityAsReadEvent>(_onMarkAllActivityAsRead);
  }

  void _onLoadRecentActivity(LoadRecentActivityEvent event, Emitter<ActivityState> emit) async {
    emit(ActivityLoading());
    try {
      final recentActivity = await getRecentActivity(NoParams());
      emit(ActivityLoaded(
        recentActivity: recentActivity,
        earlierActivity: const [],
        hasLoadedEarlier: false,
      ));
    } catch (e) {
      emit(ActivityError(message: e.toString()));
    }
  }

  void _onLoadEarlierActivity(LoadEarlierActivityEvent event, Emitter<ActivityState> emit) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;
      emit(ActivityLoading());
      try {
        final earlierActivity = await getEarlierActivity(NoParams());
        emit(ActivityLoaded(
          recentActivity: currentState.recentActivity,
          earlierActivity: earlierActivity,
          hasLoadedEarlier: true,
        ));
      } catch (e) {
        emit(ActivityError(message: e.toString()));
      }
    }
  }

  void _onMarkActivityAsRead(MarkActivityAsReadEvent event, Emitter<ActivityState> emit) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;

      // Update the activity item in state
      final updatedRecentActivity = currentState.recentActivity.map((activity) {
        if (activity.id == event.activityId) {
          // Create a copy of the activity with isRead set to true
          return ActivityEntity(
            id: activity.id,
            userId: activity.userId,
            username: activity.username,
            userProfileImageUrl: activity.userProfileImageUrl,
            type: activity.type,
            timestamp: activity.timestamp,
            relatedPostId: activity.relatedPostId,
            relatedPostImageUrl: activity.relatedPostImageUrl,
            relatedCommentText: activity.relatedCommentText,
            isRead: true,
          );
        }
        return activity;
      }).toList();

      final updatedEarlierActivity = currentState.earlierActivity.map((activity) {
        if (activity.id == event.activityId) {
          // Create a copy of the activity with isRead set to true
          return ActivityEntity(
            id: activity.id,
            userId: activity.userId,
            username: activity.username,
            userProfileImageUrl: activity.userProfileImageUrl,
            type: activity.type,
            timestamp: activity.timestamp,
            relatedPostId: activity.relatedPostId,
            relatedPostImageUrl: activity.relatedPostImageUrl,
            relatedCommentText: activity.relatedCommentText,
            isRead: true,
          );
        }
        return activity;
      }).toList();

      // Emit the new state immediately for responsive UI
      emit(ActivityLoaded(
        recentActivity: updatedRecentActivity,
        earlierActivity: updatedEarlierActivity,
        hasLoadedEarlier: currentState.hasLoadedEarlier,
      ));

      // Then perform the actual API call
      try {
        await markAsRead(event.activityId);
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(currentState);
        emit(ActivityError(message: e.toString()));
      }
    }
  }

  void _onMarkAllActivityAsRead(MarkAllActivityAsReadEvent event, Emitter<ActivityState> emit) async {
    if (state is ActivityLoaded) {
      final currentState = state as ActivityLoaded;

      // Update all activity items in state
      final updatedRecentActivity = currentState.recentActivity.map((activity) {
        return ActivityEntity(
          id: activity.id,
          userId: activity.userId,
          username: activity.username,
          userProfileImageUrl: activity.userProfileImageUrl,
          type: activity.type,
          timestamp: activity.timestamp,
          relatedPostId: activity.relatedPostId,
          relatedPostImageUrl: activity.relatedPostImageUrl,
          relatedCommentText: activity.relatedCommentText,
          isRead: true,
        );
      }).toList();

      final updatedEarlierActivity = currentState.earlierActivity.map((activity) {
        return ActivityEntity(
          id: activity.id,
          userId: activity.userId,
          username: activity.username,
          userProfileImageUrl: activity.userProfileImageUrl,
          type: activity.type,
          timestamp: activity.timestamp,
          relatedPostId: activity.relatedPostId,
          relatedPostImageUrl: activity.relatedPostImageUrl,
          relatedCommentText: activity.relatedCommentText,
          isRead: true,
        );
      }).toList();

      // Emit the new state immediately for responsive UI
      emit(ActivityLoaded(
        recentActivity: updatedRecentActivity,
        earlierActivity: updatedEarlierActivity,
        hasLoadedEarlier: currentState.hasLoadedEarlier,
      ));

      // Then perform the actual API call
      try {
        await markAllAsRead(NoParams());
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(currentState);
        emit(ActivityError(message: e.toString()));
      }
    }
  }
}