import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_event.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_state.dart';

class StoryBloc extends Bloc<StoryEvent, BaseApiState> {
  StoryBloc() : super(StoriesLoading()) {
    on<LoadStoriesEvent>(_onLoadStories);
    on<ViewStoryEvent>(_onViewStory);
    on<RefreshStoriesEvent>(_onRefreshStories);
  }

  void _onLoadStories(LoadStoriesEvent event, Emitter<BaseApiState> emit) async {
    emit(StoriesLoading());
    try {
      // In a real app, you'd fetch from API or database
      // For now, we'll use the dummy data
      final stories = StoryModel.getDummyStories();
      emit(StoriesLoaded(stories: stories, viewedStories: {}));
    } catch (e) {
      emit(StoriesError('Failed to load stories: ${e.toString()}'));
    }
  }

  void _onViewStory(ViewStoryEvent event, Emitter<BaseApiState> emit) async {
    if (state is StoriesLoaded) {
      final currentState = state as StoriesLoaded;
      final updatedViewedStories = Map<String, bool>.from(currentState.viewedStories);
      updatedViewedStories[event.storyId] = true;

      emit(currentState.copyWith(viewedStories: updatedViewedStories));
    }
  }

  void _onRefreshStories(RefreshStoriesEvent event, Emitter<BaseApiState> emit) async {
    if (state is StoriesLoaded) {
      final currentState = state as StoriesLoaded;
      emit(StoriesRefreshing(
        stories: currentState.stories,
        viewedStories: currentState.viewedStories,
      ));

      try {
        // In a real app, you'd fetch from API or database
        final stories = StoryModel.getDummyStories();
        emit(StoriesLoaded(
          stories: stories,
          viewedStories: currentState.viewedStories,
        ));
      } catch (e) {
        emit(StoriesError('Failed to refresh stories: ${e.toString()}'));
      }
    }
  }
}
