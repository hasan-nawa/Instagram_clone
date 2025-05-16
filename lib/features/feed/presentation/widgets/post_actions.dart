import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/common/common.dart';
import 'package:instagram_clone/core/widgets/comments_template.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/feed/domain/entities/post_entity.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:instagram_clone/features/feed/presentation/bloc/feed_event.dart';
import 'package:instagram_clone/utils/app_extension.dart';
import 'package:instagram_clone/utils/app_images.dart';

class PostActions extends StatelessWidget {
  const PostActions({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),

      child: Row(
        children: [
          _buildPostAction(
            onTapCount: () {},
            onTap: () {
              context.read<FeedBloc>().add(
                ToggleLikeEvent(postId: post.id, isLiked: post.isLiked),
              );
            },
            count: post.likesCount,
            iconData: post.isLiked ? AppImages.likeFill : AppImages.like,
            iconColor: !post.isLiked ? Colors.white:null

          ).paddingEnd(8),
          _buildPostAction(
            onTapCount: () {
              Common.showBottomSheet(
                context,
                CommentTemplate(),
              );
            },
            onTap: () {},
            count: post.commentsCount,
            iconData: AppImages.comment,
            iconColor: Colors.white,
          ).paddingEnd(8),
          _buildPostAction(
            onTapCount: () {},
            onTap: () {},
            iconData: AppImages.send,
            iconColor: Colors.white
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              context.read<FeedBloc>().add(
                ToggleBookmarkEvent(
                  postId: post.id,
                  isBookmarked: post.isBookmarked,
                ),
              );
            },
            child: SvgPicture.asset(
              post.isBookmarked ? AppImages.bookMark : AppImages.bookMark,color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostAction({count, required String iconData, onTap, onTapCount, Color? iconColor}) {
    return Row(
      children: [
        GestureDetector(
            onTap: onTap, child: SvgPicture.asset(iconData,color: iconColor,).paddingEnd(2)),
        if (count != null)
          InkWell(onTap: onTapCount, child: TextCustom(text: '$count')),
      ],
    );
  }
}
