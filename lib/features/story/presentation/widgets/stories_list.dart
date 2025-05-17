import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/config/theme.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/features/story/data/models/story_model.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_bloc.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_event.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_state.dart';
import 'package:instagram_clone/features/story/presentation/widgets/story_item.dart';

class StoriesList extends StatelessWidget {
  final Function(StoryModel,List<StoryModel>) onStoryTap;

  const StoriesList({
    Key? key,
    required this.onStoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryBloc, BaseApiState>(
      builder: (context, state) {
        if (state is StoriesLoading) {
          return _buildLoadingWidget();
        } else if (state is StoriesError) {
          return _buildErrorWidget(state.message);
        } else if (state is StoriesLoaded || state is StoriesRefreshing) {
          final List<StoryModel> stories;
          final Map<String, bool> viewedStories;
          
          if (state is StoriesLoaded) {
            stories = state.stories;
            viewedStories = state.viewedStories;
          } else {
            final refreshingState = state as StoriesRefreshing;
            stories = refreshingState.stories;
            viewedStories = refreshingState.viewedStories;
          }
          
          return Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.darkBgColor,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final story = stories[index];
                // Create a modified story with isViewed from bloc state
                final viewedStory = StoryModel(
                  id: story.id,
                  username: story.username,
                  userImage: story.userImage,
                  storyImage: story.storyImage,
                  isViewed: viewedStories[story.id] ?? false,
                  createdAt: story.createdAt,
                );
                
                return StoryItem(
                  story: viewedStory,
                  onTap: () {
                    // Mark as viewed in bloc

                    context.read<StoryBloc>().add(ViewStoryEvent(story.id));
                    onStoryTap(story,stories);
                  },
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
  
  Widget _buildLoadingWidget() {
    return Container(
      height: 115,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
  
  Widget _buildErrorWidget(String? errorMessage) {
    return Container(
      height: 115,
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          errorMessage ?? 'Failed to load stories',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
