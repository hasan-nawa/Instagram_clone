import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/add_comment.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/bookmark_post.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/get_post_by_id.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/like_post.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/unbookmark_post.dart';
import 'package:instagram_clone/features/post_detail/domain/usecases/unlike_post.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_event.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final GetPostById getPostById;
  final LikePost likePost;
  final UnlikePost unlikePost;
  final BookmarkPost bookmarkPost;
  final UnbookmarkPost unbookmarkPost;
  final AddComment addComment;

  PostDetailBloc({
    required this.getPostById,
    required this.likePost,
    required this.unlikePost,
    required this.bookmarkPost,
    required this.unbookmarkPost,
    required this.addComment,
  }) : super(PostDetailInitial()) {
    on<LoadPostDetailEvent>(_onLoadPostDetail);
    on<ToggleLikeEvent>(_onToggleLike);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<AddCommentEvent>(_onAddComment);
  }

  void _onLoadPostDetail(LoadPostDetailEvent event, Emitter<PostDetailState> emit) async {
    emit(PostDetailLoading());
    try {
      final post = await getPostById(event.postId);
      emit(PostDetailLoaded(post: post));
    } catch (e) {
      emit(PostDetailError(message: e.toString()));
    }
  }

  void _onToggleLike(ToggleLikeEvent event, Emitter<PostDetailState> emit) async {
    if (state is PostDetailLoaded) {
      final currentState = state as PostDetailLoaded;
      final currentPost = currentState.post;

      // Update the post with new like status
      final updatedPost = currentPost.copyWith(
        isLiked: !currentPost.isLiked,
        likesCount: currentPost.isLiked
            ? currentPost.likesCount - 1
            : currentPost.likesCount + 1,
      );

      // Emit the new state immediately for responsive UI
      emit(PostDetailLoaded(post: updatedPost));

      // Then perform the actual API call
      try {
        if (currentPost.isLiked) {
          await unlikePost(currentPost.id);
        } else {
          await likePost(currentPost.id);
        }
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(PostDetailLoaded(post: currentPost));
        emit(PostDetailError(message: e.toString()));
      }
    }
  }

  void _onToggleBookmark(ToggleBookmarkEvent event, Emitter<PostDetailState> emit) async {
    if (state is PostDetailLoaded) {
      final currentState = state as PostDetailLoaded;
      final currentPost = currentState.post;

      // Update the post with new bookmark status
      final updatedPost = currentPost.copyWith(
        isBookmarked: !currentPost.isBookmarked,
      );

      // Emit the new state immediately for responsive UI
      emit(PostDetailLoaded(post: updatedPost));

      // Then perform the actual API call
      try {
        if (currentPost.isBookmarked) {
          await unbookmarkPost(currentPost.id);
        } else {
          await bookmarkPost(currentPost.id);
        }
      } catch (e) {
        // If the API call fails, revert to the previous state
        emit(PostDetailLoaded(post: currentPost));
        emit(PostDetailError(message: e.toString()));
      }
    }
  }

  void _onAddComment(AddCommentEvent event, Emitter<PostDetailState> emit) async {
    if (state is PostDetailLoaded) {
      final currentState = state as PostDetailLoaded;
      final currentPost = currentState.post;

      // For optimistic UI, we would add the comment to the list here
      // However, as we don't have all the info for a proper comment entity,
      // we'll just reload the post after the API call

      try {
        await addComment(AddCommentParams(
          postId: currentPost.id,
          comment: event.comment,
        ));

        // Reload the post to get the updated comments
        add(LoadPostDetailEvent(postId: currentPost.id));
      } catch (e) {
        emit(PostDetailError(message: e.toString()));
      }
    }
  }
}