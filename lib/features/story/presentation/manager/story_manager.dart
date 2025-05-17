import 'package:flutter/material.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';

class StoryManager extends ChangeNotifier {
  final List<StoryModel> _stories = StoryModel.getDummyStories();
  final Map<String, bool> _viewedStories = {};

  List<StoryModel> get stories => _stories;

  void viewStory(String storyId) {
    _viewedStories[storyId] = true;
    notifyListeners();
  }

  bool isStoryViewed(String storyId) {
    return _viewedStories[storyId] ?? false;
  }
}
