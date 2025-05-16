import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/reels/domain/entities/reel_entity.dart';
import 'package:instagram_clone/features/reels/domain/usecases/bookmark_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/follow_user.dart';
import 'package:instagram_clone/features/reels/domain/usecases/get_reels.dart';
import 'package:instagram_clone/features/reels/domain/usecases/increase_share_count.dart';
import 'package:instagram_clone/features/reels/domain/usecases/like_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/unbookmark_reel.dart';
import 'package:instagram_clone/features/reels/domain/usecases/unfollow_user.dart';
import 'package:instagram_clone/features/reels/domain/usecases/unlike_reel.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_event.dart';
import 'package:instagram_clone/features/reels/presentation/bloc/reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final GetReels getReels;
  final LikeReel likeReel;
  final UnlikeReel unlikeReel;
  final BookmarkReel bookmarkReel;
  final UnbookmarkReel unbookmarkReel;
  final FollowUser followUser;
  final UnfollowUser unfollowUser;
  final IncreaseShareCount increaseShareCount;

  ReelsBloc({
    required this.getReels,
    required this.likeReel,
    required this.unlikeReel,
    required this.bookmarkReel,
    required this.unbookmarkReel,
    required this.followUser,
    required this.unfollowUser,
    required this.increaseShareCount,
  }) : super(ReelsInitial()) {
    on<LoadReelsEvent>(_onLoadReels);
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<ToggleFollowEvent>(_onToggleFollow);
    on<ShareReelEvent>(_onShareReel);
    on<ChangeCurrentReelEvent>(_onChangeCurrentReel);
  }

  void _onLoadReels(LoadReelsEvent event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());
    try {
      final reels = await getReels(NoParams());
      if (reels.isNotEmpty) {
        emit(ReelsLoaded(
          reels: reels,
          currentIndex: 0,
          currentReel: reels[0],
        ));
      } else {
        emit(const ReelsLoaded(
          reels: [],
          currentIndex: 0,
          currentReel: null,
        ));
      }
    } catch (e) {
      emit(ReelsError(message: e.toString()));
    }
  }

  void _onToggleLike(ToggleLikeEvent event, Emitter<ReelsState> emit) async {
    if (state is ReelsLoaded) {
      final currentState = state as ReelsLoaded;

      // Update the current reel optimistically
      final updatedReels = currentState.reels.map((reel) {
        if (reel.id == event.reelId) {
          return reel.copyWith(
            isLiked: !reel.isLiked,
            likesCount: reel.isLiked ? reel.likesCount - 1 : reel.likesCount + 1,
          );
        }
        return reel;
      }).toList();

      // Update current reel if it's the one being modified
      ReelEntity? updatedCurrentReel;
      if (currentState.currentReel != null && currentState.currentReel!.id == event.reelId) {
        updatedCurrentReel = currentState.currentReel!.copyWith(
          isLiked: !currentState.currentReel!.isLiked,
          likesCount: currentState.currentReel!.isLiked
              ? currentState.currentReel!.likesCount - 1
              : currentState.currentReel!.likesCount + 1,
        );
      } else {
        updatedCurrentReel = currentState.currentReel;
      }

      // Emit updated state
      emit(ReelsLoaded(
        reels: updatedReels,
        currentIndex: currentState.currentIndex,
        currentReel: updatedCurrentReel,
      ));

      // Perform the API call
      try {
        if (event.isLiked) {
          await unlikeReel(event.reelId);
        } else {
          await likeReel(event.reelId);
        }
      } catch (e) {
        // If API call fails, revert to original state
        emit(ReelsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  void _onToggleBookmark(ToggleBookmarkEvent event, Emitter<ReelsState> emit) async {
    if (state is ReelsLoaded) {
      final currentState = state as ReelsLoaded;

      // Update the current reel optimistically
      final updatedReels = currentState.reels.map((reel) {
        if (reel.id == event.reelId) {
          return reel.copyWith(
            isBookmarked: !reel.isBookmarked,
          );
        }
        return reel;
      }).toList();

      // Update current reel if it's the one being modified
      ReelEntity? updatedCurrentReel;
      if (currentState.currentReel != null && currentState.currentReel!.id == event.reelId) {
        updatedCurrentReel = currentState.currentReel!.copyWith(
          isBookmarked: !currentState.currentReel!.isBookmarked,
        );
      } else {
        updatedCurrentReel = currentState.currentReel;
      }

      // Emit updated state
      emit(ReelsLoaded(
        reels: updatedReels,
        currentIndex: currentState.currentIndex,
        currentReel: updatedCurrentReel,
      ));

      // Perform the API call
      try {
        if (event.isBookmarked) {
          await unbookmarkReel(event.reelId);
        } else {
          await bookmarkReel(event.reelId);
        }
      } catch (e) {
        // If API call fails, revert to original state
        emit(ReelsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  void _onToggleFollow(ToggleFollowEvent event, Emitter<ReelsState> emit) async {
    if (state is ReelsLoaded) {
      final currentState = state as ReelsLoaded;

      // Update the reels optimistically
      final updatedReels = currentState.reels.map((reel) {
        if (reel.userId == event.userId) {
          return reel.copyWith(
            isFollowing: !reel.isFollowing,
          );
        }
        return reel;
      }).toList();

      // Update current reel if it's from the user being followed/unfollowed
      ReelEntity? updatedCurrentReel;
      if (currentState.currentReel != null && currentState.currentReel!.userId == event.userId) {
        updatedCurrentReel = currentState.currentReel!.copyWith(
          isFollowing: !currentState.currentReel!.isFollowing,
        );
      } else {
        updatedCurrentReel = currentState.currentReel;
      }

      // Emit updated state
      emit(ReelsLoaded(
        reels: updatedReels,
        currentIndex: currentState.currentIndex,
        currentReel: updatedCurrentReel,
      ));

      // Perform the API call
      try {
        if (event.isFollowing) {
          await unfollowUser(event.userId);
        } else {
          await followUser(event.userId);
        }
      } catch (e) {
        // If API call fails, revert to original state
        emit(ReelsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  void _onShareReel(ShareReelEvent event, Emitter<ReelsState> emit) async {
    if (state is ReelsLoaded) {
      final currentState = state as ReelsLoaded;

      // Update the current reel optimistically
      final updatedReels = currentState.reels.map((reel) {
        if (reel.id == event.reelId) {
          return reel.copyWith(
            sharesCount: reel.sharesCount + 1,
          );
        }
        return reel;
      }).toList();

      // Update current reel if it's the one being shared
      ReelEntity? updatedCurrentReel;
      if (currentState.currentReel != null && currentState.currentReel!.id == event.reelId) {
        updatedCurrentReel = currentState.currentReel!.copyWith(
          sharesCount: currentState.currentReel!.sharesCount + 1,
        );
      } else {
        updatedCurrentReel = currentState.currentReel;
      }

      // Emit updated state
      emit(ReelsLoaded(
        reels: updatedReels,
        currentIndex: currentState.currentIndex,
        currentReel: updatedCurrentReel,
      ));

      // Perform the API call
      try {
        await increaseShareCount(event.reelId);
      } catch (e) {
        // If API call fails, revert to original state
        emit(ReelsError(message: e.toString()));
        emit(currentState);
      }
    }
  }

  void _onChangeCurrentReel(ChangeCurrentReelEvent event, Emitter<ReelsState> emit) {
    if (state is ReelsLoaded) {
      final currentState = state as ReelsLoaded;
      if (event.index >= 0 && event.index < currentState.reels.length) {
        emit(ReelsLoaded(
          reels: currentState.reels,
          currentIndex: event.index,
          currentReel: currentState.reels[event.index],
        ));
      }
    }
  }
}