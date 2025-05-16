import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/core/usecases/usecase.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/feed/domain/usecases/bookmark_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/get_posts.dart';
import 'package:instagram_clone/features/feed/domain/usecases/like_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/unbookmark_post.dart';
import 'package:instagram_clone/features/feed/domain/usecases/unlike_post.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_event.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, BaseApiState> {
  final GetPosts getPosts;
  final LikePost likePost;
  final UnlikePost unlikePost;
  final BookmarkPost bookmarkPost;
  final UnbookmarkPost unbookmarkPost;

  FeedBloc({
    required this.getPosts,
    required this.likePost,
    required this.unlikePost,
    required this.bookmarkPost,
    required this.unbookmarkPost,
  }) : super(FeedInitial()) {
    on<LoadFeedEvent>(_onLoadFeed);
    on<RefreshFeedEvent>(_onRefreshFeed);
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
  }

  void _onLoadFeed(LoadFeedEvent event, Emitter<BaseApiState> emit) async {
    emit(FeedLoading());
    try {
      final posts = await getPosts(NoParams());
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  void _onRefreshFeed(
    RefreshFeedEvent event,
    Emitter<BaseApiState> emit,
  ) async {
    emit(FeedLoading());
    try {
      final posts = await getPosts(NoParams());
      emit(FeedLoaded(posts: posts));
    } catch (e) {
      emit(FeedError(message: e.toString()));
    }
  }

  void _onToggleLike(ToggleLikeEvent event, Emitter<BaseApiState> emit) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      // Fixed: Explicitly specify non-nullable type
      final List<PostEntity> updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          // Create a new PostEntity with updated isLiked status and likesCount
          return _updatePostLikeStatus(post, !event.isLiked);
        }
        return post;
      }).toList();
      // Emit the new state immediately for responsive UI
      emit(FeedLoaded(posts: updatedPosts));

      try {
        if (event.isLiked) {
          await unlikePost(event.postId);
        } else {
          await likePost(event.postId);
        }

        // In a real app, we might update the post in state
        // For now, we'll just refresh the feed
        // add(RefreshFeedEvent());
      } catch (e) {
        emit(FeedLoaded(posts: currentState.posts));
        emit(FeedError(message: e.toString()));
      }
    }


  }

  void _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<BaseApiState> emit,
  ) async {
    if (state is FeedLoaded ){

      final currentState = state as FeedLoaded;
      final List<PostEntity> updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          // Create a new PostEntity with updated isBookmarked status
          return _updatePostBookmarkStatus(post, !event.isBookmarked);
        }
        return post;
      }).toList();

      // Emit the new state immediately for responsive UI
      emit(FeedLoaded(posts: updatedPosts));


      try {
        if (event.isBookmarked) {
          await unbookmarkPost(event.postId);
        } else {
          await bookmarkPost(event.postId);
        }

        // In a real app, we might update the post in state
        // For now, we'll just refresh the feed
        // add(RefreshFeedEvent());
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(FeedLoaded(posts: currentState.posts));
        emit(FeedError(message: e.toString()));
      }
    }

  }

  PostEntity _updatePostLikeStatus(PostEntity post, bool newLikeStatus){
    final newLikesCount = newLikeStatus
        ? post.likesCount + 1
        : post.likesCount - 1;

    return PostEntity(
      id: post.id,
      username: post.username,
      userProfileImageUrl: post.userProfileImageUrl,
      imageUrl: post.imageUrl,
      caption: post.caption,
      likesCount: newLikesCount,
      commentsCount: post.commentsCount,
      createdAt: post.createdAt,
      isLiked: newLikeStatus,
      isBookmarked: post.isBookmarked,
      hashtags: post.hashtags,
    );
  }

  // Helper method to create a new post with updated bookmark status
  PostEntity _updatePostBookmarkStatus(PostEntity post, bool newBookmarkStatus) {
    return PostEntity(
      id: post.id,
      username: post.username,
      userProfileImageUrl: post.userProfileImageUrl,
      imageUrl: post.imageUrl,
      caption: post.caption,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      createdAt: post.createdAt,
      isLiked: post.isLiked,
      isBookmarked: newBookmarkStatus,
      hashtags: post.hashtags,
    );
  }
}
