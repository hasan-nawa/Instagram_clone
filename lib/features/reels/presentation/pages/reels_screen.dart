import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:instagram_clone/core/common/common.dart';
import 'package:instagram_clone/core/widgets/comments_template.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_bloc.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_event.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_state.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/reel_actions.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/reel_info.dart';
import 'package:instagram_clone/features/reels/presentation/widgets/reel_video_player.dart';
import 'package:instagram_clone/di.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReelsBloc>()..add(LoadReelsEvent()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Reels',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              onPressed: () {
                // Navigate to create reels
              },
            ),
          ],
        ),
        body: BlocBuilder<ReelsBloc, ReelsState>(
          builder: (context, state) {
            if (state is ReelsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReelsLoaded) {
              if (state.reels.isEmpty) {
                return const Center(child: Text('No reels available'));
              }
              return PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.reels.length,
                onPageChanged: (index) {
                  context.read<ReelsBloc>().add(
                    ChangeCurrentReelEvent(index: index),
                  );
                },
                itemBuilder: (context, index) {
                  final reel = state.reels[index];
                  final isCurrentReel = index == state.currentIndex;

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Video Player
                      ReelVideoPlayer(
                        videoUrl: reel.videoUrl,
                        thumbnailUrl: reel.thumbnailUrl,
                        isCurrentReel: isCurrentReel,
                      ),

                      // Gradient overlay for better text visibility
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            colors: [Colors.black54, Colors.transparent],
                          ),
                        ),
                      ),

                      // Content overlays
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Left side - user info and caption
                                Expanded(
                                  child: ReelInfo(
                                    username: reel.username,
                                    userProfileImageUrl:
                                        reel.userProfileImageUrl,
                                    caption: reel.caption,
                                    audioName: reel.audioName,
                                    audioOwner: reel.audioOwner,
                                    isFollowing: reel.isFollowing,
                                    onFollow: (userId, isFollowing) {
                                      context.read<ReelsBloc>().add(
                                        ToggleFollowEvent(
                                          userId: reel.userId,
                                          isFollowing: reel.isFollowing,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                // Right side - action buttons
                                ReelActions(
                                  reelId: reel.id,
                                  userId: reel.userId,
                                  isLiked: reel.isLiked,
                                  isBookmarked: reel.isBookmarked,
                                  likesCount: reel.likesCount,
                                  commentsCount: reel.commentsCount,
                                  sharesCount: reel.sharesCount,
                                  onLike: (reelId, isLiked) {
                                    context.read<ReelsBloc>().add(
                                      ToggleLikeEvent(
                                        reelId: reelId,
                                        isLiked: isLiked,
                                      ),
                                    );
                                  },
                                  onBookmark: (reelId, isBookmarked) {
                                    context.read<ReelsBloc>().add(
                                      ToggleBookmarkEvent(
                                        reelId: reelId,
                                        isBookmarked: isBookmarked,
                                      ),
                                    );
                                  },
                                  onShare: (reelId) {
                                    context.read<ReelsBloc>().add(
                                      ShareReelEvent(reelId: reelId),
                                    );

                                    // Show a share sheet (simplified for this example)
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Sharing reel...'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  onComment: () {
                                    // Show comment bottom sheet
                                    _showCommentsSheet(context, reel.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            } else if (state is ReelsError) {
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
                        context.read<ReelsBloc>().add(LoadReelsEvent());
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No reels available'));
          },
        ),
      ),
    );
  }

  void _showCommentsSheet(BuildContext context, String reelId) {
    Common.showBottomSheet(
      context,
      CommentTemplate(),
    );
  }
}

