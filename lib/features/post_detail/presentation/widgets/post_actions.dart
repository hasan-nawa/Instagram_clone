import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/core/common/common.dart';
import 'package:instagram_clone/core/widgets/comments_template.dart';
import 'package:instagram_clone/core/widgets/core_widgets.dart';
import 'package:instagram_clone/features/post_detail/domain/entities/post_detail_entity.dart';
import 'package:instagram_clone/features/post_detail/presentation/bloc/post_detail_bloc.dart';
import 'package:instagram_clone/utils/app_extension.dart';
import 'package:instagram_clone/utils/app_images.dart';

import '../bloc/post_detail_event.dart' show ToggleBookmarkEvent, ToggleLikeEvent;

class PostActionsDetails extends StatelessWidget {
  const PostActionsDetails({super.key, required this.post});

  final PostDetailEntity post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),

      child: Row(
        children: [
          _buildPostAction(
            onTapCount: () {},
            onTap: () {
              context.read<PostDetailBloc>().add(
                ToggleLikeEvent(),
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
            onTap: () {
              Common.showBottomSheet(
                context,
                CommentTemplate(),
              );
            },
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
              context.read<PostDetailBloc>().add(
                ToggleBookmarkEvent(),
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
