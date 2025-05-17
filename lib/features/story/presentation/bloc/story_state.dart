import 'package:instagram_clone/core/api_call_status.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';

class StoriesLoading extends BaseApiState {
  @override
  MyApiStatus toApiStatus() {
    return Loading();
  }
}

class StoriesLoaded extends BaseApiState {
  final List<StoryModel> stories;
  final Map<String, bool> viewedStories;

  StoriesLoaded({
    required this.stories,
    required this.viewedStories,
  });
  
  @override
  MyApiStatus toApiStatus() {
    return Success();
  }

  @override
  List<Object> get props => [stories, viewedStories];

  StoriesLoaded copyWith({
    List<StoryModel>? stories,
    Map<String, bool>? viewedStories,
  }) {
    return StoriesLoaded(
      stories: stories ?? this.stories,
      viewedStories: viewedStories ?? this.viewedStories,
    );
  }

  bool isStoryViewed(String storyId) {
    return viewedStories[storyId] ?? false;
  }
}

class StoriesError extends BaseApiState {
  final String message;
  
  StoriesError(this.message);
  
  @override
  MyApiStatus toApiStatus() {
    return Error(message: message);
  }
}

class StoriesRefreshing extends BaseApiState {
  final List<StoryModel> stories;
  final Map<String, bool> viewedStories;

  StoriesRefreshing({
    required this.stories,
    required this.viewedStories,
  });
  
  @override
  MyApiStatus toApiStatus() {
    return Refreshing();
  }

  @override
  List<Object> get props => [stories, viewedStories];
}
