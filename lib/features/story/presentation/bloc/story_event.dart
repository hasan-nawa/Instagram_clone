import 'package:equatable/equatable.dart';

abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadStoriesEvent extends StoryEvent {
  const LoadStoriesEvent();
}

class ViewStoryEvent extends StoryEvent {
  final String storyId;

  const ViewStoryEvent(this.storyId);

  @override
  List<Object?> get props => [storyId];
}

class RefreshStoriesEvent extends StoryEvent {
  const RefreshStoriesEvent();
}
