import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/core/base_api_state.dart';
import 'package:instagram_clone/core/widgets/shimmer_widget.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_state.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/my_app_bar.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_card.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:instagram_clone/di.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_event.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_bloc.dart';
import 'package:instagram_clone/features/story/presentation/bloc/story_event.dart';
import 'package:instagram_clone/features/story/presentation/widgets/stories_list.dart';
import 'package:instagram_clone/features/story/presentation/pages/story_viewer_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<FeedBloc>()..add(LoadFeedEvent()),
        ),
        BlocProvider(
          create: (context) => StoryBloc()..add(const LoadStoriesEvent()),
        ),
      ],
      child: BlocBuilder<FeedBloc, BaseApiState>(
        builder: (context, state) {
          final apiStatus = state.toApiStatus(); // Convert state to MyApiStatus

          return Scaffold(
            body: MyWidgetsAnimator(
              hideSuccessWidgetWhileRefreshing: false,
              apiCallStatus: apiStatus, // Use MyApiStatus directly
              holdingWidget:
                  () => const Center(child: CircularProgressIndicator()),
              loadingWidget: () => ShimmerWidget(),
              errorWidget:
                  (message) =>
                      Center(child: Text("Error occurred! ${message}")),
              emptyWidget:
                  () => const Center(child: Text("No data available.")),
              refreshWidget:
                  () => const Center(child: CircularProgressIndicator()),
              successWidget: () {
                FeedLoaded successState = state as FeedLoaded;
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<FeedBloc>().add(RefreshFeedEvent());
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      MyAppBar(title: 'For you',),
                      // Stories section
                      SliverToBoxAdapter(
                        child: StoriesList(
                          onStoryTap: (story,stories) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => StoryViewerScreen(story: story,stories:stories,initialIndex: 0,),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverList.builder(
                        itemCount: successState.posts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PostCard(post: successState.posts[index]!);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
