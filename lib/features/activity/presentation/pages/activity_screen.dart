import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/activity/domain/entities/activity_entity.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_bloc.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_event.dart';
import 'package:instagram_clone/features/activity/presentation/bloc/activity_state.dart';
import 'package:instagram_clone/features/post_detail/presentation/pages/post_detail_screen.dart';
import 'package:instagram_clone/features/profile/presentation/pages/profile_screen.dart';
import 'package:instagram_clone/di.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ActivityBloc>()..add(LoadRecentActivityEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activity'),
          actions: [
            BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoaded && _hasUnreadActivity(state)) {
                  return IconButton(
                    icon: const Icon(Icons.done_all),
                    onPressed: () {
                      context.read<ActivityBloc>().add(
                        MarkAllActivityAsReadEvent(),
                      );
                    },
                    tooltip: 'Mark all as read',
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ActivityBloc, ActivityState>(
          builder: (context, state) {
            if (state is ActivityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ActivityLoaded) {
              return _buildActivityList(context, state);
            } else if (state is ActivityError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ActivityBloc>().add(
                          LoadRecentActivityEvent(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No activity available'));
          },
        ),
      ),
    );
  }

  bool _hasUnreadActivity(ActivityLoaded state) {
    return state.recentActivity.any((activity) => !activity.isRead) ||
        state.earlierActivity.any((activity) => !activity.isRead);
  }

  Widget _buildActivityList(BuildContext context, ActivityLoaded state) {
    return ListView(
      children: [
        if (state.recentActivity.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Recent',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          ...state.recentActivity.map(
            (activity) => _buildActivityItem(context, activity),
          ),
        ],

        if (!state.hasLoadedEarlier) ...[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextButton(
                onPressed: () {
                  context.read<ActivityBloc>().add(LoadEarlierActivityEvent());
                },
                child: const Text('Load Earlier'),
              ),
            ),
          ),
        ] else if (state.earlierActivity.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: Text(
              'Earlier',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          ...state.earlierActivity.map(
            (activity) => _buildActivityItem(context, activity),
          ),
        ],
      ],
    );
  }

  Widget _buildActivityItem(BuildContext context, ActivityEntity activity) {
    return GestureDetector(
      onTap: () {
        // Mark activity as read
        context.read<ActivityBloc>().add(
          MarkActivityAsReadEvent(activityId: activity.id),
        );

        // Navigate based on activity type
        if (activity.type == ActivityType.like ||
            activity.type == ActivityType.comment ||
            activity.type == ActivityType.mention) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      PostDetailScreen(postId: activity.relatedPostId ?? ''),
            ),
          );
        } else if (activity.type == ActivityType.follow ||
            activity.type == ActivityType.followRequest) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(username: activity.username),
            ),
          );
        }
      },
      child: Container(
        color:
            activity.isRead
                ? null
                : Theme.of(context).primaryColor.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(activity.userProfileImageUrl),
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: activity.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${_getActivityText(activity)}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    if (activity.relatedCommentText != null)
                      Text(
                        activity.relatedCommentText!,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.grey[600]
                                  : Colors.grey[400],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 2),
                    Text(
                      timeago.format(activity.timestamp),
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[500]
                                : Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (activity.relatedPostImageUrl != null) ...[
                const SizedBox(width: 12),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    activity.relatedPostImageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
              if (activity.type == ActivityType.followRequest) ...[
                const SizedBox(width: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Accept follow request
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        minimumSize: const Size(60, 30),
                      ),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        // Decline follow request
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 0,
                        ),
                        minimumSize: const Size(60, 30),
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
              if (activity.type == ActivityType.suggestedUser) ...[
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // Follow suggested user
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 0,
                    ),
                    minimumSize: const Size(60, 30),
                  ),
                  child: const Text('Follow'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getActivityText(ActivityEntity activity) {
    switch (activity.type) {
      case ActivityType.like:
        return 'liked your post.';
      case ActivityType.comment:
        return 'commented on your post.';
      case ActivityType.follow:
        return 'started following you.';
      case ActivityType.mention:
        return 'mentioned you in a comment.';
      case ActivityType.followRequest:
        return 'requested to follow you.';
      case ActivityType.suggestedUser:
        return 'is suggested for you to follow.';
      case ActivityType.postUpdate:
        return 'posted new content.';
      default:
        return 'interacted with your content.';
    }
  }
}
