import 'package:flutter/material.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_caption.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_hashtags.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_header.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_liked.dart';
import 'package:instagram_clone/features/feed/presentation/widgets/post_time.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';
import 'package:instagram_clone/features/post_detail/presentation/widgets/post_actions.dart';
import 'package:instagram_clone/features/post_detail/presentation/widgets/post_media.dart';
import 'package:instagram_clone/utils/app_extension.dart';

class PostCardDetails extends StatelessWidget {
  const PostCardDetails({super.key, required this.post});

  final PostDetailEntity post;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header with user info
          PostHeader(
            username: post.username,
            userProfileImageUrl: post.userProfileImageUrl,
          ),

          PostMediaDetails(post: post,),

          // Post actions (like, comment, share, bookmark)
          PostActionsDetails(post: post).paddingSymmetric(vertical: 10),

          // Likes count
          PostsLiked(
            userProfileImageUrl: post.userProfileImageUrl,
            name: post.username,
          ),

          // Caption
          if (post.caption.isNotEmpty)
            PostCaption(username: post.username, caption: post.caption),

          // Hashtags
          if (post.hashtags.isNotEmpty) PostHashtags(hashtags: post.hashtags),

          //Post time
          PostTime(createdAt: post.createdAt),
        ],
      ),
    );
  }
}
