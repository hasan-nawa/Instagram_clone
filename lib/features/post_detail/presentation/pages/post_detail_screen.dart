import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_bloc.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_event.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_state.dart';
import 'package:instagram_clone/di.dart';
import 'package:instagram_clone/features/post_detail/presentation/widgets/post_card.dart';
import 'package:instagram_clone/utils/app_images.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool showLike = false;
  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  animateLike() async {
    setState(() {
      showLike = true;
    });
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      showLike = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              sl<PostDetailBloc>()
                ..add(LoadPostDetailEvent(postId: widget.postId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post'),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                // Show post options
              },
            ),
          ],
        ),
        body: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
            if (state is PostDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostDetailLoaded) {
              final post = state.post;
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      slivers: [

                        // Post image
                        SliverToBoxAdapter(
                          child: SizedBox(
                            width: double.infinity,
                            child: PostCardDetails(post: post)
                          ),
                        ),
                      ]
                    ),
                  ),
                ]
              );
            } else if (state is PostDetailError) {
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
                        context.read<PostDetailBloc>().add(
                          LoadPostDetailEvent(postId: widget.postId),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text('No post data available'));
          },
        ),
      ),
    );
  }
}
